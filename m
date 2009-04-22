From: James Cloos <cloos@jhcloos.com>
Subject: Re: [PATCH 1/1] Improve progress display in kB range.
Date: Wed, 22 Apr 2009 10:33:19 -0400
Message-ID: <m34owgoj08.fsf@lugabout.jhcloos.org>
References: <cover.1240115957.git.cloos@jhcloos.com>
	<d03620ac4d99f3280df31708032a072a4a6cd96e.1240115957.git.cloos@jhcloos.com>
	<alpine.LFD.2.00.0904210054190.6741@xanadu.home>
	<m3skk2szgv.fsf@lugabout.jhcloos.org>
	<alpine.LFD.2.00.0904211319570.6741@xanadu.home>
	<m3d4b5oj76.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 22 16:44:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwdZS-0002yA-QN
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 16:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbZDVOf2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2009 10:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbZDVOf1
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 10:35:27 -0400
Received: from eagle.jhcloos.com ([207.210.242.212]:1529 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbZDVOf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 10:35:26 -0400
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 9475540281; Wed, 22 Apr 2009 14:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1240410925;
	bh=TauKL+7bKrklyr9D3477nHicl3JTcNsjHkbQaAoH8Xw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=hrf9NJqAHt5hvne3F/MpzAzaFN9Svp6wcv6GZMHS2+8KZy47G1lWNzZjAoLe0ZVYN
	 WfF5BPWw3G1OK635LuQ7vIZvP1zM46mAi/NOZcl703kkxlhPW2FZb5CLpJAEbNnDPr
	 9K9nu84da9O96M6hFeRLpL/+7gtMZmYxrJNrz2U0=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 6BF9B8CDC2; Wed, 22 Apr 2009 14:33:44 +0000 (UTC)
In-Reply-To: <m3d4b5oj76.fsf@lugabout.jhcloos.org> (James Cloos's message of
	"Tue, 21 Apr 2009 16:16:53 -0400")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.92 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAI1J
 REFUOE+lU9ESgCAIg64P1y+ngUdxhl5H8wFbbM0OmUiEhKkCYaZThXCo6KE5sCbA1DDX3genvO4d
 eBQgEMaM5qy6uWk4SfBYfdu9jvBN9nSVDOKRtwb+I3epboOsOX5pZbJNsBJFvmQQ05YMfieIBnYX
 FK2N6dOawd97r/e8RjkTLzmMsiVgrAoEugtviCM3v2WzjgAAAABJRU5ErkJggg==
Copyright: Copyright 2009 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
X-Hashcash: 1:29:090422:nico@cam.org::PPT1h3UHXY236tQ1:0000HJcmf
X-Hashcash: 1:29:090422:git@vger.kernel.org::wam2tUTVctGxVlaS:00000000000000000000000000000000000000000CIrdC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117201>

|> Therefore, in practice =E2=80=94 and as I have witnessed several tho=
usand times
|> without ever having seen a contrary example =E2=80=94 display_throug=
hput() is
|> called *durring* a download only when total & 0xFFF =3D=3D 0xFFF.

Another possibility is an off-by-one error.  The relevant part of fill(=
)
looks like:

,----< excerpt from index-pack.c:fill() >
|   do {
|     ssize_t ret =3D xread(input_fd, input_buffer + input_len,
|                         sizeof(input_buffer) - input_len);
|     if (ret <=3D 0) {
|       if (!ret)
|         die("early EOF");
|       die("read error on input: %s", strerror(errno));
|     }
|     input_len +=3D ret;
|     if (from_stdin)
|       display_throughput(progress, consumed_bytes + input_len);
|   } while (input_len < min);
|   return input_buffer;
| }
`----

if *(input_buffer + ret) is the last read octet rather than the next
empty octet, that would also explain what I see.

Perhaps that call to display_throughput() should have an extra +1?

-JimC
--=20
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
