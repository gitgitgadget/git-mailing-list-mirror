From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] git-submodule: New subcommand 'summary' (1) -
 code framework
Date: Sat, 01 Mar 2008 18:16:02 -0800
Message-ID: <7vskz9x44d.fsf@gitster.siamese.dyndns.org>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
 <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
 <7vk5km7vir.fsf@gitster.siamese.dyndns.org>
 <46dff0320803010227r5024d152g259a6a07a2441351@mail.gmail.com>
 <7vejauxj38.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 03:17:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVdlP-0000Rv-Ix
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 03:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbYCBCQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 21:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbYCBCQQ
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 21:16:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbYCBCQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 21:16:16 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CF12328C3;
	Sat,  1 Mar 2008 21:16:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E958928C1; Sat,  1 Mar 2008 21:16:09 -0500 (EST)
In-Reply-To: <7vejauxj38.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 01 Mar 2008 12:52:43 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75714>

Junio C Hamano <gitster@pobox.com> writes:

> "Ping Yin" <pkufranky@gmail.com> writes:
> ...
>> man grep says
>>  In  basic regular expressions the metacharacters ?, +, {, |, (, and )
>> lose their special meaning; instead use the backslashed versions \?,
>> \+, \{, \|, \(, and \).
>>
>> Doen't it mean that '\|' is BRE ?
>
> It just says unlike in ERE, these characters are not special in BRE; it
> does not at all say using backslash like \?, \+, and \| makes them so.
>
> And they are not.  \(...\), \{m\}, \{m,\} and \{m,n\} are part of BRE, but
> the two you used (\+ and \|) are not.  GNU accept these two as extensions,
> but other POSIX implementations may have troubles with them.
>
>   http://www.opengroup.org/onlinepubs/000095399/basedefs/xbd_chap09.html
>
> Please be gentle to porters to non GNU systems.  Either stay inside BRE
> (which I think we have managed to do with our usage of grep) or explicitly
> ask for ERE with "grep -E".

I think this would help people new to our codebase.

Also 

    Message-ID: <7v4pdtgjf0.fsf@gitster.siamese.dyndns.org>
    Subject: Re: [PATCH] git-filter-branch could be confused by similar names
    Date: Fri, 04 Jan 2008 17:17:39 -0800

aka

    http://article.gmane.org gmane.comp.version-control.git/69630

---

 Documentation/CodingGuidelines |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 3b042db..994eb91 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -53,6 +53,18 @@ For shell scripts specifically (not exhaustive):
  - We do not write the noiseword "function" in front of shell
    functions.
 
+ - As to use of grep, stick to a subset of BRE (namely, no \{m,n\},
+   [::], [==], nor [..]) for portability.
+
+   - We do not use \{m,n\};
+
+   - We do not use -E;
+
+   - We do not use ? nor + (which are \{0,1\} and \{1,\}
+     respectively in BRE) but that goes without saying as these
+     are ERE elements not BRE (note that \? and \+ are not even part
+     of BRE -- making them accessible from BRE is a GNU extension).
+
 For C programs:
 
  - We use tabs to indent, and interpret tabs as taking up to
