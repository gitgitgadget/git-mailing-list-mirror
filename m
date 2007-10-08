From: Florian Weimer <fweimer@bfk.de>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and  optimize it a bit
Date: Mon, 08 Oct 2007 10:54:32 +0200
Message-ID: <82k5py6l6f.fsf@mid.bfk.de>
References: <1190625904-22808-2-git-send-email-madcoder@debian.org>
	<20071007140052.GA3260@steel.home>
	<20071007172425.bb691da9.tihirvon@gmail.com>
	<20071007143912.GB10024@artemis.corp> <87sl4nlyg0.fsf@catnip.gol.com>
	<857ilylxhm.fsf@lola.goethe.zz> <20071007215432.GC2765@steel.home>
	<EF81F7DD-73C7-4B6F-92D2-4A143CA05365@wincent.com>
	<20071007223140.GG2765@steel.home> <87odfapefc.fsf@catnip.gol.com>
	<20071008072312.GA22552@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miles Bader <miles@gnu.org>, Alex Riesen <raa.lkml@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	David Kastrup <dak@gnu.org>,
	Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 10:55:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeoOD-00038U-Ah
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 10:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbXJHIyt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 04:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbXJHIyt
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 04:54:49 -0400
Received: from mx01.bfk.de ([193.227.124.2]:38278 "EHLO mx01.bfk.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708AbXJHIys convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Oct 2007 04:54:48 -0400
Received: from mx00.int.bfk.de ([10.119.110.2])
	by mx01.bfk.de with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	id 1IeoNk-0000iE-VY; Mon, 08 Oct 2007 10:54:33 +0200
Received: from fweimer by bfk.de with local id 1IeoNk-0006d2-Ro; Mon, 08 Oct 2007 10:54:32 +0200
In-Reply-To: <20071008072312.GA22552@artemis.corp> (Pierre Habouzit's message of "Mon, 08 Oct 2007 09:23:12 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60299>

* Pierre Habouzit:

>> So I think the last line can just be:
>>=20
>>    return a->len - b->len;
>
>   Won't work because ->len are size_t and return value is int, so on =
64
> bits platform, this has chances to overflow.

Nit: It can overflow on 32-bit, too.

And "int len" in the first line of the function body should be
"size_t len".

Moving that to a compare_int/compare_size_t function should help;
AFAIK there's no short idiom which does the job.

--=20
=46lorian Weimer                <fweimer@bfk.de>
BFK edv-consulting GmbH       http://www.bfk.de/
Kriegsstra=DFe 100              tel: +49-721-96201-1
D-76133 Karlsruhe             fax: +49-721-96201-99
