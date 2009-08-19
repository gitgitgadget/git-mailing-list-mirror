From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 6/6 (v4)] support for path name caching in rev-cache
Date: Tue, 18 Aug 2009 23:52:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908182313100.6044@xanadu.home>
References: <op.uys3qwlmtdk399@sirnot.private>
 <alpine.LFD.2.00.0908172235360.6044@xanadu.home>
 <c77435a80908180431k2f91e1ffye25aa8895908ddb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 05:56:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdcHw-0005kE-LP
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 05:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbZHSDxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 23:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbZHSDxR
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 23:53:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40835 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbZHSDxR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 23:53:17 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOL00M5CUS9OQC0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 Aug 2009 23:52:58 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <c77435a80908180431k2f91e1ffye25aa8895908ddb7@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126500>

On Tue, 18 Aug 2009, Nick Edelen wrote:

> I'll reply to *these* posts with everything fixed.  Then after that
> hopefully I can just make patches for the patchset (yo dawg) and save
> everyone a lot of bandwidth.

We have bandwidth to spare.  The bandwidth is cheaper than the time 
needed to reconstruct a patch series using a previous series and having 
to modify it with additional patches.  In other words, always make it 
easier for the people willing to review and test your stuff.

Now... testing your latest series looks promising.  The speed increase 
is really there which is good.

However, there are still some issues:

|$ rm -rf .git/rev-cache/
|$ git rev-list --all --objects > /tmp/l1
|$ git rev-cache add --all
|objects: 115789
|paths: 1535
|f0cb1f09e309ee426c307cb85bb870467877de77
|endpoints:
|S 1cae2b588249e8b45239faebc658c7fa45948932
|S 4aec0d2391eb569776e332d9c15b354cd50a64c5
|S 1ff19ffed62bb581cd8eb635fe6e65ffca7ba1d0
|S fcd8ea7a91ad55d094a78c826083ebac149d81e5
|S 181301656f7a1086adcc41c3661551f190635003
|S 2898400a882bfb3c475fc2b53330912edc8a81f8
|S 7c7f2ebdb98f4844347f68b6e64c4968fa7f38e5
|S 1d9d1698ceb7b553f3cb1fdaa3150f0e85ab9cca
|S 348f73cc1db2d7b1412c40eba72319855e2959ff
|S fedc7d5458bd8e2e9589567041228a24a8d7eb4c
|S 0f57bf3ae8f0000de83907f0a674d70a879f7753
|S 7354ca323e31aa2d469498d06feebdcea137e93a
|S d47e28a143f40ad31b88e6d7b9b18bae60d21b01
|S 991ab5ed8769cd1a425b96b92772c89244bc957c
|S 07827905813bce9cadb9db2faac5848a61c7e69f
|S aff6ae5e2f10c4a8e399bf5aa446a58d74444aba
|S 6849908a55d0e7a95fa715310f739cfab4dd8def
|S f073bf0b423cf6a2ee5a5e9b5e70be3b91897a7f
|S b9376927508a2401c20bdb5c5c0608797f822524
|S 9d412d627575478ffdda4209eca9babde061fe2f
|S d187b5de2c2895f6cb4a544e78fcbc1ecf3ba172
|final return value: 0
|$ git rev-list --all --objects > /tmp/l2
|$ wc -l -c /tmp/l1 /tmp/l2
|  109382  5525988 /tmp/l1
|  109382  5473891 /tmp/l2

Result with the rev-cache populated returns the same number of 
revisions, but not the same amount of data.

|$ diff -u /tmp/l1 /tmp/l2
|--- /tmp/l1     2009-08-18 23:22:03.000000000 -0400
|+++ /tmp/l2     2009-08-18 23:25:02.000000000 -0400
|@@ -4,221 +4,38 @@
| ff212f80287ab15162035d39bac511f6edacca00
| 69527b0cc148b5fa320cce68e82216f0ba7117d9
| fdbe5cf05690accc4d701e2e8d8c69baccf76812
|-9d412d627575478ffdda4209eca9babde061fe2f
|-b9376927508a2401c20bdb5c5c0608797f822524
|-f073bf0b423cf6a2ee5a5e9b5e70be3b91897a7f
|-fd31906d2285fb914e51a2fb78de6683b481951b
|-7415dcd3bc6a6103d532d75b77897399af2bc015
|-397b844013068a658e2c4dbea05fb57559433f6e
|-15173bda08b5481c2014f04228b95f90f1e500e6
|-d6758648e1ff1f7ace2ddb3682a8189ec634925b
|-7475ee6d358167e2e4dcdea6c7a67f3619c35315
|-83bf4a2869721ba728c5c8b0bdb8ad9a3a43b94b
|-5f50d92cc49150a83e8fa7b352cb9e14ae4d6570
[...]

The object order appears to be rather different.  Why so?

|$ sort /tmp/l1 > /tmp/l1_sorted
|$ sort /tmp/l2 > /tmp/l2_sorted
|$ diff -u /tmp/l1_sorted  /tmp/l2_sorted
|--- /tmp/l1_sorted      2009-08-18 23:35:48.000000000 -0400
|+++ /tmp/l2_sorted      2009-08-18 23:36:23.000000000 -0400
|@@ -1,7 +1,7 @@
| 000079a2eaef17b7eae70e1f0f635557ea67b644
| 00013cafe6980411aa6fdd940784917b5ff50f0a man1/git-merge-base.1
| 000147bbe4a00525d68efb1358c013812e10dcca contrib/thunderbird-patch-inline/README
|-0001710072c5f0f708323d99e1bb632d7911c842 Documentation/git-peek-remote.txt
|+0001710072c5f0f708323d99e1bb632d7911c842 git-peek-remote.txt
| 000182eacf99cde27d5916aa415921924b82972c
| 0002d8a2fb6add585184350d11284840293dea4d git-daemon.html
| 0003692409f153dd725b3455dfc2e128276cfbe2
|@@ -29,7 +29,7 @@
| 0012954b6f795d75d442f4c58f29dc194888d022 remote.c
| 0012ba2108aa42947dedf19f3db2de73a67cc4f5
| 00133ed4f910f42ae7aaba32bcda1c1e261bc776 man1/git-update-server-info.1
|-001503205b24d5c20ec10792c4ab6c4c7221bcb7 Documentation/diff-format.txt
|+001503205b24d5c20ec10792c4ab6c4c7221bcb7 diff-format.txt
| 0016a48251abefed11efc919703d980a21c95f2c
| 00183cbb3d0f60852d7286e766c9b631c0c1f952
| 00188e33e825c8000dee8e3f4209a264615ce8a1
[...]

So... Why is the leading path component dropped sometimes?  That 
explains the output size difference.  And the drop is not coherent 
either:

|$ grep "diff-format.txt" /tmp/l2
|b71712473ed13020bca3f133ea4a28c5081b7f9e diff-format.txt
|1eeb1c76838c1911fc4d57b36a16dece0538809a diff-format.txt
|aafd3a394126e4718b593eb5727412e16d2334e4 diff-format.txt
|400cbb3b1c120b93278472678ee7bdb87a74f95b diff-format.txt
|2c3a4c433b2a6d2b0846243a4f1dbebeed45236e diff-format.txt
|9709c35c98bc678d1f2e339c8e2d4bbcd7e6231f diff-format.txt
|001503205b24d5c20ec10792c4ab6c4c7221bcb7 diff-format.txt
|18d49d2c3baa81983b19a938598eb091fb7809ef diff-format.txt
|e38a1f14056b2e3cfe3c281eb7df7e5b44d520db diff-format.txt
|378e72f38f37eef50135c3907ccd605652f4fd96 diff-format.txt
|883c1bb0a638d97278cdb66e288bc766a32626af diff-format.txt
|e4520e28e53661159454e02c703be772d43bbc09 diff-format.txt
|ed4ebcbab76c23e599a3f3d62072e16d2cbe7cb1 diff-format.txt
|617d8f526f914360c612d2e2822f1c883c9f5115 diff-format.txt
|0398b408c05d2dccb9806c0add6d1acd13871d74 diff-format.txt
|97756ec03086614051d5780b00825e24ee5ef56f diff-format.txt
|2060ae2fcb9935ed11ecb71a093ad22c661339bf Documentation/diff-format.txt
|174d63a1ee4238aac88c76daee6f3f1bead0d6b5 Documentation/diff-format.txt
|b426a14f5e5fa29bfdb8f026d995dc182930073d Documentation/diff-format.txt
|d1d0d2d3dc8760a8030313de3dd14a942d0fc2bf Documentation/diff-format.txt
|bfe634dcd3664d0e3b18b212db2f3f16b63a385b Documentation/diff-format.txt
|dacd8fb53488fadd7ebb6c1964e60a60072eae80 Documentation/diff-format.txt
|6e9fa8cdb70faead4649f71aea4fff8f50d17271 Documentation/diff-format.txt
|424e75a1c2d4747226ac1b55caac90b544f8f273 Documentation/diff-format.txt
|811d143808a13034de41c1cdcc834ef838d01ce8 Documentation/diff-format.txt
|9298d79e51bf87ccff66357227c7df4db4c820c4 Documentation/diff-format.txt
|d6ce035419081e3fbfc2375ac667517f5f52c980 Documentation/diff-format.txt
|6748761ef61cf35473ee304bc8bd44134cdccaf4 Documentation/diff-format.txt
|1d92a01a02543e55d0feb3541ee594fbc638136c Documentation/diff-format.txt
|f85a605f0a336f506cf5cf46476a43e4c56b3e66 Documentation/diff-format.txt
|7e9a515ad74b16c3f82eba71a9503c6696c77503 Documentation/diff-format.txt
|9e645399752e9b18f097840906fc640a1121d982 Documentation/diff-format.txt
|1a99e85ee58bfc47192e3e3cd409af948c989f80 Documentation/diff-format.txt
|3af197cd2c62f990f7a67ac52277ccf0521d268e Documentation/diff-format.txt

I think you'll have to fix those issues.


Nicolas
