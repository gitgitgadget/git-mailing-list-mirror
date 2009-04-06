From: David Abrahams <dave@boostpro.com>
Subject: Re: git diff bug?
Date: Mon, 6 Apr 2009 05:09:32 -0400
Message-ID: <1BF9172A-BE91-4D1C-932A-EB9FD79BA402@boostpro.com>
References: <m2ocvdkyul.fsf@boostpro.com> <20090404014527.GA13350@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 06 11:21:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lql1J-0007fY-N5
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 11:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713AbZDFJUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 05:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754690AbZDFJUB
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 05:20:01 -0400
Received: from boost-consulting.com ([206.71.190.141]:55487 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577AbZDFJUA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 05:20:00 -0400
X-Greylist: delayed 619 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Apr 2009 05:20:00 EDT
Received: from [192.168.188.150] (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boost-consulting.com (Postfix) with ESMTPSA id 9AC091CC26;
	Mon,  6 Apr 2009 02:07:41 -0700 (PDT)
In-Reply-To: <20090404014527.GA13350@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115798>


On Apr 3, 2009, at 9:45 PM, Jeff King wrote:

> On Fri, Apr 03, 2009 at 09:10:42PM -0400, David Abrahams wrote:
>
>> Please see
>> http://github.com/techarcana/elisp/commit/63d672c296316c85690085930b05c642b88a9978#diff-2
>>
>> Note how the @@ ... @@ clauses are followed by text from the previous
>> line's comment.  Not sure, but this strikes me as a line-ending  
>> issue.
>> custom.el was originally built on a linux machine; now I'm using a  
>> Mac.
>
> This is as designed. The original file ("git show e7dd7db") contains  
> (my
> numbering seems different than what git produces; it is produced by  
> "nl"
> which is maybe treating some line endings differently earlier in the
> file):
>
>   102   '(mm-attachment-override-types (quote ("text/x-vcard"  
> "application/pkcs7-mime" "application/x-pkcs7-mime" "application/ 
> pkcs7-signature" "application/x-pkcs7-signature" "image/*")) nil nil "
>   103  Added image/* to display attached images inline")
>   104   '(mm-discouraged-alternatives (quote ("text/html" "text/ 
> richtext" "image/.*")) nil nil "
>   105  The documentation for this variable says it all")
>   106   '(mm-inline-text-html-with-images t)
>   107   '(muse-project-alist (quote (("WikiPlanner" ("~/ 
> plans" :default "index" :major-mode planner-mode :visit-link planner- 
> visit-link)))))
>   108   '(org-agenda-files (quote ("~/organizer.org")))
>
> The changed text in your diff starts on 108. So we show 105-107 as
> context lines. The text after the @@ clause is the "function header";
> this is equivalent to "-p" in GNU diff. It's basically a guess about  
> the
> most interesting context to show, and looks alphabetic characters that
> are left-aligned. In the case of lisp, it really isn't all that
> interesting (and what looks so weird is that your file contains
> a lot of
>
>  "\nSome text"
>
> so the text strings are all left-aligned. You can customize the regex
> used to guess at the function header. See "defining a custom
> hunk-header" in "git help attributes".

Hmm, so I tried sticking this .gitattributes in my repo

   *.el   diff=el
   [diff "el"]
         xfuncname = "^(\\(def[a-z]+ .+)$"

and git diff barfed with

   "el"] is not a valid attribute name: .gitattributes:2
   "^(\\(def[a-z]+ is not a valid attribute name: .gitattributes:3

What am I missing?  I tried googling, but from what turns up for me,  
it doesn't look like anyone else has ever tried to use this feature!

TIA,

--
David Abrahams
BoostPro Computing
http://boostpro.com
