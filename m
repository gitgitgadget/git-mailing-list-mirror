From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/4] completion: improve 'git --exec-path' completion
Date: Fri, 13 Apr 2012 13:04:36 -0500
Message-ID: <20120413180436.GA2387@burratino>
References: <1334274603-3277-1-git-send-email-felipe.contreras@gmail.com>
 <1334274603-3277-5-git-send-email-felipe.contreras@gmail.com>
 <20120413060845.GA15610@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 20:05:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIkrn-0006Kl-Ne
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 20:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163Ab2DMSE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 14:04:57 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42810 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab2DMSEy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 14:04:54 -0400
Received: by iagz16 with SMTP id z16so4546242iag.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 11:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yTv9SmPKI+GKJKNWBOvExDo08/HHu4wZjDN1W5JdjoE=;
        b=ogkIFfw+ybQ68Zasmt0YXcy+7EpgUwFPg5O8XRjreQTMgDhyRQc2xXpIztcHmBwonw
         5kapxOHuUKVAp664/c/t33Jbu60W92H+EXBj33XbmiR/ZVrKviokLCHreFnkzpf1zlQz
         eAVVr84rM2jKcZ11JszqOG0/tJ/nvxby49DbunU/jgZBOAS/2unQA9ZtEChq9DiWdG2+
         B2hhTOm2jlV5D2vKuMaxnnq+mVW/+q+6F2oYJRkUuZ2iNhhH2t8osD0Jtx7R3A1asZez
         BIFS+fBQY1YfUNLdMFVRWs1sY9sIYf5dHy1I4pXuu0njYJVCNEMVBjRR9zFRhxKTLdTo
         7WAg==
Received: by 10.50.47.135 with SMTP id d7mr2470524ign.66.1334340293643;
        Fri, 13 Apr 2012 11:04:53 -0700 (PDT)
Received: from burratino (adsl-99-24-202-99.dsl.chcgil.sbcglobal.net. [99.24.202.99])
        by mx.google.com with ESMTPS id cg9sm8259522igb.17.2012.04.13.11.04.42
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 11:04:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120413060845.GA15610@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195428>

On Fri, Apr 13, 2012 at 01:08:45AM -0500, Jonathan Nieder wrote:
> Felipe Contreras wrote:

>> +++ b/contrib/completion/git-completion.bash
>> @@ -2638,7 +2638,7 @@ _git ()
>>  			--git-dir=
>>  			--bare
>>  			--version
>> -			--exec-path
>> +			--exec-path=
[...]
> Thanks.
>
> "git --exec-path" means to print the name of the directory where git
> stores its subcommands and other helpers.  I have no thoughts either
> way about whether a user typing
>
> 	git --exec-p<TAB>
>
> is more likely to be asking for the current exec-path or intending to
> override it.

In other words, how about something like this?  Tests left as an exercise
to the interested reader.

-- >8 --
Subject: completion: do not add trailing space when completing --exec-path

--exec-path looks like to the completion script like an unambiguous
successful completion script, but it is wrong.  The user could be
trying to do

	git --exec-path; # print name of helper directory

or

	git --exec-path=/path/to/alternative/helper/dir <subcommand>

so the most helpful thing to do is to leave out the trailing space and
leave it to the operator to type an equal sign or carriage return
according to the situation.

Reported-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/completion/git-completion.bash |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 31f714da..ecbf2172 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -307,12 +307,14 @@ __git_ps1 ()
 # __gitcomp_1 requires 2 arguments
 __gitcomp_1 ()
 {
-	local c IFS=' '$'\t'$'\n'
+	local c word IFS=' '$'\t'$'\n'
 	for c in $1; do
-		case "$c$2" in
-		--*=*) printf %s$'\n' "$c$2" ;;
-		*.)    printf %s$'\n' "$c$2" ;;
-		*)     printf %s$'\n' "$c$2 " ;;
+		word=$c$2
+		case $word in
+		--*=*) printf %s$'\n' "$word" ;;
+		*.)    printf %s$'\n' "$word" ;;
+		*\$)   printf %s$'\n' "${word%\$}" ;;
+		*)     printf %s$'\n' "$word " ;;
 		esac
 	done
 }
@@ -2638,7 +2640,7 @@ _git ()
 			--git-dir=
 			--bare
 			--version
-			--exec-path
+			--exec-path\$
 			--html-path
 			--work-tree=
 			--namespace=
-- 
1.7.10
