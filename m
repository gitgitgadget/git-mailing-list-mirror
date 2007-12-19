From: Eric Blake <ebb9@byu.net>
Subject: Re: bug with .gitattributes diff and embedded NUL
Date: Wed, 19 Dec 2007 07:19:16 -0700
Message-ID: <47692864.3090300@byu.net>
References: <4768A70F.8020904@byu.net> <7vve6vw5kg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 15:16:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4zir-0000f1-VO
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 15:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbXLSOQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 09:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753478AbXLSOQJ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 09:16:09 -0500
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:44343 "EHLO
	QMTA03.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753237AbXLSOQI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 09:16:08 -0500
Received: from OMTA11.emeryville.ca.mail.comcast.net ([76.96.30.36])
	by QMTA03.emeryville.ca.mail.comcast.net with comcast
	id SbLu1Y0030mlR8U0A0FS00; Wed, 19 Dec 2007 14:16:13 +0000
Received: from [192.168.0.103] ([67.166.125.73])
	by OMTA11.emeryville.ca.mail.comcast.net with comcast
	id SeGB1Y0071b8C2B8X00000; Wed, 19 Dec 2007 14:16:13 +0000
X-Authority-Analysis: v=1.0 c=1 a=peNS-BvKifkA:10 a=xe8BsctaAAAA:8 a=Q7a-wNeiOaxzT8kBS1oA:9 a=stLAj2xvVdzF272i5m_fwPW9UfgA:4 a=eDFNAWYWrCwA:10 a=rPt6xJ-oxjAA:10
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.666
In-Reply-To: <7vve6vw5kg.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68907>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Junio C Hamano on 12/18/2007 11:40 PM:
> Eric Blake <ebb9@byu.net> writes:
> 
>> Looking closer at .dotest/0001, the diff is indeed invalid, containing the
>> single line
> 
> That dataflow loses NUL.  Fixing
> rebase not to reuse the e-mailed patch dataflow is on my to-do list, but
> has been slipping.
> 
> I think you can use "rebase -m" to work this issue around.

Indeed, after learning about git-rebase -m and git-mergetool, adding the
merge option alongside the diff option for the file in question, and
teaching emacs that it should use emerge-diff-options "-a" so that it can
handle embedded NUL, I was finally able to use git-mergetool to do a sane
merge of the differences in the mostly-text file.  Thanks!

But it raised some additional issues:

Is there a way to specify custom merge tools, rather than the current
hard-coded list valid for merge.tool?  For example, what if I prefer
emacs' ediff driver over its emerge driver?

Using merge.tool of emerge leaves junk around when the merge is aborted.
Before I edited emacs' emerge-diff-options, the subsidiary diff3 was
failing because it treated the file to merge as binary even though git was
trying to treat it as text.  As a result, emerge left behind all of its
command-line argument files (file.{BASE,LOCAL,REMOTE}.pid), and git did
not clean any of them up.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHaShk84KuGfSFAYARAkDtAJ0XhhhbeJZJS6td3/aeOlxd7iuoawCgiVY6
3s+aMxRO1vjKf/EqncKW2jE=
=GrcF
-----END PGP SIGNATURE-----
