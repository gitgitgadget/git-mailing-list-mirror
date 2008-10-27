From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: problems with clone and .gitattributes
Date: Mon, 27 Oct 2008 14:46:41 -0400
Message-ID: <ee2a733e0810271146r5b21213eg989045e4bf42d99a@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 19:48:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuX8D-0001Jj-AR
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 19:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbYJ0Sqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 14:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbYJ0Sqr
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 14:46:47 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:6267 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbYJ0Sqr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 14:46:47 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1901238muf.1
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 11:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=T9YQ9SS0bDOO9P0oU0V4XdQ2NvSQb+F+fTHd//R4Y5U=;
        b=xuS6PjlTld14MkBC8iWjj8y87/2V0gqoa9btEO9XNbP/hJ8APxseMfDeuGTzI94x02
         9kjm2uicAdrulFdnAFO2HzWMagC/fWmIKHyUFLvWUcCyCY5+bdIaMcjk2pNfIuCHGuqX
         yOh+XKBB7Fd57KIdkd9IClHz9H8tGymkiFDtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=q/4AoykyjXSg4k7k77NrusOkfwTHKxGoHbC0eX9zgmY/SXiJydE80YVa3lb4QZkkpP
         tWIWCJTE/de/eB1gcP0wKICGO/Df0rqs5rWcXqFP0mlaBgz5OJbCrEp3Tayt4eNvqNVq
         ZGMf7iXQ2CwZXDGVMcrGU7x87sSV0+byLg3og=
Received: by 10.187.242.9 with SMTP id u9mr574204far.96.1225133201947;
        Mon, 27 Oct 2008 11:46:41 -0700 (PDT)
Received: by 10.187.193.16 with HTTP; Mon, 27 Oct 2008 11:46:41 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99249>

Hi Everyone,
I am using .gitattributes with clean/smudge filters to optimize
storage of OpenOffice binary files (zip compressed). So far it works
fine except for clone operation.
Apparently, "git clone" does not call smudge filter when checking out a branch.
I have to manually remove openoffice files and then do "git co -f" to
re-checkout them  again, this time smudge filter gets applied.

There is a little catch-22 problem here. .gitattributes are stored
in-tree and git clone does not know about these files existence until
it checks the tree out, by that time it is already too late to apply
filters.

Of course, there could be several obvious workarounds:

(1) git clone can redo checkout when it finds files affected by gitattributes

(2) before doing checkout "git clone" inspects tree-object and looks
for .gitattributes files. If found it checks them out first before all
other files. Now it can apply the attributes found as the checkout
process progresses.

IMHO, both workarounds are somewhat clumsy.
Is there anything cleaner that can be done to solve the problem?

--Leo--
