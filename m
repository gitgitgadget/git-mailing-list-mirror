From: Ross Lagerwall <rosslagerwall@gmail.com>
Subject: git grep performance regression
Date: Mon, 14 Jan 2013 22:38:00 +0000
Message-ID: <20130114223800.GA12708@hobo.wolfson.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 23:45:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TusmC-0001q9-Pp
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 23:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758342Ab3ANWos convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jan 2013 17:44:48 -0500
Received: from mail-wg0-f41.google.com ([74.125.82.41]:64082 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757568Ab3ANWor (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 17:44:47 -0500
Received: by mail-wg0-f41.google.com with SMTP id ds1so1442397wgb.0
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 14:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        bh=4ZECn8i0pysVsYK1ooZJf/XCcoMpus4nrOBRi0byPI0=;
        b=IWO4JYsSQP0kB13AS9rivjlqiBO89LJtKwqVKUm6IoB75p3u2dqJrttjK3LDBjQSP2
         m66LUtkgmAnPajKpb9N7C2kkvbu45S78Ca3XiL9xXJymUki+qZpqzBF/cwqhHGp0oA38
         TkhxlmvG4Sw/dQQAktqDJ/UL+zJt78Din7+9G9N+AnMxq8rwLk2J/OH9as8HiJHiqDus
         WsNs0WsGDVFF+CQaJFBQ4XkN2PB5fdfJcUZjjeKVZlXu3vvzmZS596mtjJuCwehC7MmF
         GW92RZr4NDydaerfOq26tkobOrH71tT/vQCNheZbz/03VNbpzEpVifkK/5Q8+CWTwyYZ
         QheQ==
X-Received: by 10.180.20.177 with SMTP id o17mr119373wie.24.1358203083199;
        Mon, 14 Jan 2013 14:38:03 -0800 (PST)
Received: from hobo ([2001:630:212:600:d63d:7eff:fe2c:aa8c])
        by mx.google.com with ESMTPS id e6sm890133wiz.1.2013.01.14.14.38.02
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Jan 2013 14:38:02 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213539>

Hi,

I have noticed a performance regression in git grep between v1.8.1 and
v1.8.1.1:

On the kernel tree:
=46or git 1.8.1:
$ time git grep foodsgsg

real   0m0.158s
user   0m0.290s
sys    0m0.207s

=46or git 1.8.1.1:
$ time /tmp/g/bin/git grep foodsgsg

real   0m0.501s
user   0m0.707s
sys    0m0.493s


A bisect seems to indicate that it was introduced by 94bc67:
commit 94bc671a1f2e8610de475c2494d2763355a99f65
Author: Jean-No=C3=ABl AVILA <avila.jn@gmail.com>
Date:   Sat Dec 8 21:04:39 2012 +0100

    Add directory pattern matching to attributes
   =20
    The manpage of gitattributes says: "The rules how the pattern
    matches paths are the same as in .gitignore files" and the gitignor=
e
    pattern matching has a pattern ending with / for directory matching=
=2E
   =20
    This rule is specifically relevant for the 'export-ignore' rule use=
d
    for git archive.
   =20
    Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Regards
--=20
Ross Lagerwall
