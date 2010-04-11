From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: [PATCH 1/2 v2] Add a basic idea section for git-blame.
Date: Sun, 11 Apr 2010 11:13:30 -0700
Message-ID: <4BC2114A.5080406@pcharlan.com>
References: <1270894530-6486-1-git-send-email-struggleyb.nku@gmail.com> <1270894530-6486-2-git-send-email-struggleyb.nku@gmail.com> <7veiinw0bw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Bo Yang <struggleyb.nku@gmail.com>, git@vger.kernel.org,
	trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 20:14:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O11fR-0007Pk-15
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 20:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556Ab0DKSNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 14:13:39 -0400
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:37199 "EHLO
	swarthymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752456Ab0DKSNi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 14:13:38 -0400
Received: from [192.168.0.119] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	by swarthymail-a1.g.dreamhost.com (Postfix) with ESMTP id 5A0248F227;
	Sun, 11 Apr 2010 11:13:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100404 Thunderbird/3.0.4
In-Reply-To: <7veiinw0bw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144673>

On 04/10/2010 12:53 PM, Junio C Hamano wrote:
> Bo Yang <struggleyb.nku@gmail.com> writes:
> 
>> +With `-M`, this command detects same lines of the current blaming code
>> +inside the current file. And it will shift the blame to the author of
>> +the original lines instead of author of current blaming code. It does
>> +the same for `-C` except that it will search across file boundary and
>> +multiple commits.
> 
> I grant you that the understanding what M/C options do by the end users
> (the target audience of the document) would improve if they understood the
> above paragraph.  And I know you thought the text leading to the above
> paragraph (omitted) would help them understand what this paragraph tells
> them.
> 
> But I think we should try to do better.  We can always say "With a
> technical description of how it works internally, you can understand why
> these options give you the behaviour you want", but that should be the
> last resort when we cannot give meaningful description without going into
> the implementation details.
> 
> It may also help git hacker wannabes (not end users) to have more detailed
> and precise description of how the algorithm works in a separate document
> in the Documentation/technical/ area, but that is a separate issue.
> 
> If the goal is to help the end users use M/C options and understand the
> output better, can't we take a more direct approach?
> 
> It doesn't really matter to them _why_ only B is blamed to the parent in
> "A B" -> "B A" movement without -M (and your "BASIC IDEA" section is too
> sketchy for readers to guess why, even if they wanted to learn the
> implementation detail, which they typically don't).
> 
> Things like:
> 
>     - they can use -M to annotate across block-of-lines swappage within a file;
>     - use of -M adds cost --- it spends extra cycles;
>     - similarly -C annotates across block-of-lines swappage between files;
>     - use -f -C adds larger cost; ...
> 
> are the only important things they want to know about, no?
> 
>  Documentation/blame-options.txt |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
> index 4833cac..5d5ed37 100644
> --- a/Documentation/blame-options.txt
> +++ b/Documentation/blame-options.txt
> @@ -79,14 +79,15 @@ of lines before or after the line given by <start>.
>  	of the --date option at linkgit:git-log[1].
>  
>  -M|<num>|::
> -	Detect moving lines in the file as well.  When a commit
> -	moves a block of lines in a file (e.g. the original file
> -	has A and then B, and the commit changes it to B and
> -	then A), the traditional 'blame' algorithm typically blames
> -	the lines that were moved up (i.e. B) to the parent and
> -	assigns blame to the lines that were moved down (i.e. A)
> -	to the child commit.  With this option, both groups of lines
> -	are blamed on the parent.
> +	Detect moved or copied lines within a file. When a commit
> +	moves or copies a block of lines (e.g. the original file
> +	has A and then B, and the commit changes it to B and then
> +	A), the traditional 'blame' algorithm notices only the

There's an extraneous "the" at the end of this line.

Other than that everything you say here sounds like a good idea to me.

--Pete

> +	half of the movement and typically blames the lines that were
> +	moved up (i.e. B) to the parent and assigns blame to the lines
> +	that were moved down (i.e. A) to the child commit.  With this
> +	option, both groups of lines are blamed on the parent by
> +	running extra passes of inspection.
>  +
>  <num> is optional but it is the lower bound on the number of
>  alphanumeric characters that git must detect as moving
> @@ -94,7 +95,7 @@ within a file for it to associate those lines with the parent
>  commit.
>  
>  -C|<num>|::
> -	In addition to `-M`, detect lines copied from other
> +	In addition to `-M`, detect lines moved or copied from other
>  	files that were modified in the same commit.  This is
>  	useful when you reorganize your program and move code
>  	around across files.  When this option is given twice,
