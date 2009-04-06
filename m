From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git diff bug?
Date: Mon, 06 Apr 2009 16:44:58 +0200
Message-ID: <49DA156A.1000105@drmicha.warpmail.net>
References: <m2ocvdkyul.fsf@boostpro.com> <20090404014527.GA13350@coredump.intra.peff.net> <1BF9172A-BE91-4D1C-932A-EB9FD79BA402@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 16:46:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqq60-0001M3-RU
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 16:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbZDFOpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 10:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbZDFOpG
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 10:45:06 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50462 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750847AbZDFOpE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 10:45:04 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 6EE253126E0;
	Mon,  6 Apr 2009 10:45:02 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 06 Apr 2009 10:45:02 -0400
X-Sasl-enc: 6EPbSk7f3lSzu43mkBA+D0CDeR9f4NIkujhIrCPHFopL 1239029102
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BCA141AD49;
	Mon,  6 Apr 2009 10:45:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090406 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1BF9172A-BE91-4D1C-932A-EB9FD79BA402@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115839>

David Abrahams venit, vidit, dixit 06.04.2009 11:09:
> 
> On Apr 3, 2009, at 9:45 PM, Jeff King wrote:
> 
>> On Fri, Apr 03, 2009 at 09:10:42PM -0400, David Abrahams wrote:
>>
>>> Please see
>>> http://github.com/techarcana/elisp/commit/63d672c296316c85690085930b05c642b88a9978#diff-2
>>>
>>> Note how the @@ ... @@ clauses are followed by text from the previous
>>> line's comment.  Not sure, but this strikes me as a line-ending  
>>> issue.
>>> custom.el was originally built on a linux machine; now I'm using a  
>>> Mac.
>>
>> This is as designed. The original file ("git show e7dd7db") contains  
>> (my
>> numbering seems different than what git produces; it is produced by  
>> "nl"
>> which is maybe treating some line endings differently earlier in the
>> file):
>>
>>   102   '(mm-attachment-override-types (quote ("text/x-vcard"  
>> "application/pkcs7-mime" "application/x-pkcs7-mime" "application/ 
>> pkcs7-signature" "application/x-pkcs7-signature" "image/*")) nil nil "
>>   103  Added image/* to display attached images inline")
>>   104   '(mm-discouraged-alternatives (quote ("text/html" "text/ 
>> richtext" "image/.*")) nil nil "
>>   105  The documentation for this variable says it all")
>>   106   '(mm-inline-text-html-with-images t)
>>   107   '(muse-project-alist (quote (("WikiPlanner" ("~/ 
>> plans" :default "index" :major-mode planner-mode :visit-link planner- 
>> visit-link)))))
>>   108   '(org-agenda-files (quote ("~/organizer.org")))
>>
>> The changed text in your diff starts on 108. So we show 105-107 as
>> context lines. The text after the @@ clause is the "function header";
>> this is equivalent to "-p" in GNU diff. It's basically a guess about  
>> the
>> most interesting context to show, and looks alphabetic characters that
>> are left-aligned. In the case of lisp, it really isn't all that
>> interesting (and what looks so weird is that your file contains
>> a lot of
>>
>>  "\nSome text"
>>
>> so the text strings are all left-aligned. You can customize the regex
>> used to guess at the function header. See "defining a custom
>> hunk-header" in "git help attributes".
> 
> Hmm, so I tried sticking this .gitattributes in my repo
> 
>    *.el   diff=el
>    [diff "el"]
>          xfuncname = "^(\\(def[a-z]+ .+)$"
> 
> and git diff barfed with
> 
>    "el"] is not a valid attribute name: .gitattributes:2
>    "^(\\(def[a-z]+ is not a valid attribute name: .gitattributes:3
> 
> What am I missing?  I tried googling, but from what turns up for me,  
> it doesn't look like anyone else has ever tried to use this feature!

Well, I don't think anayone else has tried putting config lines into
.gitattributes ;)

The "*.el" line goes into .gitattributes (or .git/info/a...), the other
lines are config lines and thus goe into .git/config or .gitconfig.

Michael
