From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: Intermittent failures in t9119
Date: Sat, 4 Dec 2010 17:21:38 -0800 (PST)
Message-ID: <97465.53475.qm@web30008.mail.mud.yahoo.com>
References: <7vmxoml1p7.fsf@alter.siamese.dyndns.org>
Reply-To: "David D. Kilzer" <ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 02:30:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PP3QS-0000Rd-Rz
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 02:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755831Ab0LEB2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 20:28:22 -0500
Received: from web30008.mail.mud.yahoo.com ([209.191.69.25]:40882 "HELO
	web30008.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755341Ab0LEB2V (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 20:28:21 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Dec 2010 20:28:21 EST
Received: (qmail 53632 invoked by uid 60001); 5 Dec 2010 01:21:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1291512098; bh=sguEgk2DvJVpBPuVuzib7mQ6cxnwLn0u7N58N4cfbOc=; h=Message-ID:X-YMail-OSG:Received:X-RocketYMMF:X-Mailer:References:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=jcfdaIf19xFjcnVAHj3UAJLZhzDpF6EY4EtgBHLOskfpCwIszXQuL9DPgRyYKyFQ8g5EuihDXavwg4/BwY1S+KYHdp1PipzBy8g8clU/bQy1b7ZVMATyEWFtHOYjL425Z+EyoLbJoIRD9F/xtz3XOyF1uPBc/cGHdphHUY3PZpU=
X-YMail-OSG: VirxUj4VM1kXZ3e78uUYqJZ3hREp8Ie5hTKZiiyzV1IhBdH
 eooYlnStJ72vOww9As9BFZ0ZyYpwz1zumThJE8j224qYN1KniUO9vQgBjWKE
 0DMM7AdcgG6dgeExdGx6BFWLcxM_G7ir.jMYNEyKrmwYlIT988IgGRRrKcY_
 GfXNBGyenzC7BMBfDxWv4gFPFv2ZeUVTew.k7WJHSPCekd8emv20fGelIWGd
 KxxyltMrFBQs3q0vpWU89RDWA6LLNdCVg_MAwgvaacN5bN4PpqLhyZIz3PVL
 C1l5q8IJvn7m7._knHU2FadTO7Tryj622q4ehiounp1IvGQEnt1a0TYJeWvZ
 1GjlJ8EwwI7lFLpLi_0c6bJXhT2R.VCXT7po-
Received: from [17.202.32.26] by web30008.mail.mud.yahoo.com via HTTP; Sat, 04 Dec 2010 17:21:38 PST
X-RocketYMMF: ddkilzer
X-Mailer: YahooMailRC/553 YahooMailWebService/0.8.107.285259
In-Reply-To: <7vmxoml1p7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162924>

On Fri, December 3, 2010 at 6:19:16 PM, Junio C Hamano wrote:

> I am  seeing breakages from the said test:
> 
>     not ok - 6 info  file
>     #
>     #                (cd svnwc; svn info file) > expected.info-file  &&
>     #                (cd gitwc; git svn info file) > actual.info-file &&
>      #               test_cmp expected.info-file  actual.info-file
> 
>     : trash  directory.t9119-git-svn-info/master; diff *.info-file
>      12c12
>     < Text Last Updated: 2010-12-04 00:34:58 +0000 (Sat,  04 Dec 2010)
>     ---
>     > Text Last Updated:  2010-12-04 00:34:57 +0000 (Sat, 04 Dec 2010)
> 
> I do not know if we should  expect output from "svn info" to match exactly
> like the above.  Is "Text  Last Updated" supposed to show the stat
> timestamp of the working tree (I see  "(stat $path)[9]" there)?  If so,
> unless the checkout/update in svnwc  and gitwc prior to this test was done
> within the same second, we do not have  a good reason to expect that these
> files should be identical.


The modification timestamp (mtime) for the two files should be in sync due to 
this line in t9119-git-svn-info.sh in 'setup repository and import':

        ptouch gitwc/file svnwc/file &&

> I  _think_ "svn info file" actually gives the timestamp of the revision
> that  touched the file the last (in their linear worldview of the history),
> so  perhaps this is demonstrating the real bug, but only when the test runs
> very  slowly?


What platform/OS is the test failing on?  I can't reproduce it on an 8-core Mac 
Pro with Mac OS X 10.6.5.

Dave
