From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: inotify daemon speedup for git [POC/HACK]
Date: Wed, 28 Jul 2010 07:44:26 +0000
Message-ID: <AANLkTinuq9Q_RADtQwvVTn-kDCw7cg7JcdkhbQnek9Tw@mail.gmail.com>
References: <20100727122018.GA26780@pvv.org>
	<AANLkTinuU6b1vmRFuBrA4Tc5H6gmC5cMP3Pa8EYz-8JE@mail.gmail.com>
	<9E67A084-4EDB-4CCB-A771-11B97107F4EF@gmail.com>
	<AANLkTi=oA33M4DmS5FyDx7Wn1DFrUGcmhSYkvcSYMc2r@mail.gmail.com>
	<20100728000009.GE25268@spearce.org>
	<AANLkTimkLrTwavErFkyaUTSVU-2s3me5f+cyqNFp7n+D@mail.gmail.com>
	<52EDBD9A-2961-4F66-88B3-07BF873FA994@gmail.com>
	<AANLkTi=TQnyATgJ0LSdR3qeeCVAgu+wOFcHmHUBguPiV@mail.gmail.com>
	<AANLkTinabaO3csi3TBRJKPTZ1zVGgK8-ijs6h1YUkT-n@mail.gmail.com>
	<20100728060646.GA16400@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Joshua Juran <jjuran@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 09:44:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe1JZ-0001Qj-Te
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 09:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289Ab0G1Ho2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 03:44:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33410 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab0G1Ho0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 03:44:26 -0400
Received: by iwn7 with SMTP id 7so4581633iwn.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 00:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=b58Eninfg9yp6d7k1eDdtZ0NUdKLCgdbrHtmDtYYYNA=;
        b=xxJ487/bruwpxLkxH90+MLLJFW5LT3dUnbnHBY7vGdKFMb6bhIDrhlqaZtkhK4Iuwi
         EJbuH1J0X7P44XZTrXMfYpY1VfSPji2AGwJRk1psyrObWw8x8+mjSiowtkvXxgc661Li
         9RlfYddfdK9fv7Zvbktr/NruCTlAOnp7YWXkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=P8q1c9xTUl96RqrHO46OC4QQsPAigxNSI86VZ8cvhHIXyyr6sZSMQ7xLpqDzW9Tg87
         8/LikXK6r7lG8NSv4h99rA/sYyE2J1Iknx+cb9a+BSPi0+yajLVpch/YCNLJU7vGOMsz
         m06AZsONZmc+Me2YuwOLqCxhZ1wnnNW+hX1d8=
Received: by 10.231.191.138 with SMTP id dm10mr11734684ibb.126.1280303066278; 
	Wed, 28 Jul 2010 00:44:26 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 28 Jul 2010 00:44:26 -0700 (PDT)
In-Reply-To: <20100728060646.GA16400@dert.cs.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152054>

On Wed, Jul 28, 2010 at 06:06, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Sverre Rabbelier wrote:
>
>> Also, sqlite is known to scale, is exactly one file
>> worth of dependency, what's not to love (other than having to suppor=
t
>> upgrading to 'index vSqlite').
>
> The frequent fsync()-ing. =C2=A0Though that seems to be a problem wit=
h
> pretty much anything that does not involve rewriting the index
> with each change.

SQLite has an option to turn that off [1], but I don't know if it has
an equivalent feature to manually call fsync when you need that.

Anyway, I've been very impressed by SQLite in every way. I'd try it
before designing my own fileformat, especially something involving
binary/sequential search. It's not a large dependency, and can easily
be bundled in compat/.

1. http://www.sqlite.org/pragma.html#pragma_synchronous
