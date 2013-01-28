From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 6/7] read-cache: refuse to create index referring to
 external objects
Date: Mon, 28 Jan 2013 13:18:12 +0700
Message-ID: <CACsJy8BwCCAZyMZ2w9fyMaNJsHRNp2V3Aen8g3drAkZ4y9mfBg@mail.gmail.com>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
 <1359016940-18849-6-git-send-email-pclouds@gmail.com> <7vpq0ubdec.fsf@alter.siamese.dyndns.org>
 <CACsJy8C3tLOHCK4Qc--W630do0M=xLKSMoYUxxv2_GDaUXaRww@mail.gmail.com>
 <7vpq0t3x60.fsf@alter.siamese.dyndns.org> <CACsJy8BJZgyEn1n2GWgAVSGhSkVUO-P=GXwR02OcDf0ziTTRaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 07:19:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzi3d-0005mR-2e
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 07:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224Ab3A1GSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 01:18:44 -0500
Received: from mail-oa0-f42.google.com ([209.85.219.42]:43576 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab3A1GSm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 01:18:42 -0500
Received: by mail-oa0-f42.google.com with SMTP id j1so2448955oag.15
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 22:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=IJzqglONqwQ+2zzn7FHgk4R+v7unG2qsR0Ig1WYY4Cw=;
        b=ObZE4Av7AyGyn8XKjBgzX6gG9KejNMAAvF2cexMB9lOMC26vEAMMAodsLLXpDtdTrV
         SjEqYp62UNMoHxDEz9ucyxmmwCSxh5mFIOA+i4SjNNrcqRvvliozayMecIHPIc0xaB2p
         00ohOz/hLqsqvVjqZDVmQeco+fkf4lroZFjokMoQjZUAWNgnL/qXNe+kWzeD2ySsQ0xu
         vSI4192kloHSWA7KVGMQH+B5k9I0rv8NZ/bhOa+CfOysGXnBiBUCcWIxeeRhHA41bk9X
         rue+FgVtc0tw1TXsZXakBMTyr0cg7GDPX9T5RZDgdL994VbuFLZtsq2VJ1D2s6wpOBQC
         kb/Q==
X-Received: by 10.182.12.4 with SMTP id u4mr2298649obb.74.1359353922262; Sun,
 27 Jan 2013 22:18:42 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Sun, 27 Jan 2013 22:18:12 -0800 (PST)
In-Reply-To: <CACsJy8BJZgyEn1n2GWgAVSGhSkVUO-P=GXwR02OcDf0ziTTRaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214812>

On Mon, Jan 28, 2013 at 12:48 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> Regardless the submodule odb issue, I think we should prefer
> reading local loose objects over alternate packed ones.

I think I went from one problem to another and did not make it clear.
The reason behind this preference is security. With "all packs first"
reading order, someone can create a pack in the alternate source and
that pack will override the same local loose objects (local packed
ones are safe). If someone can create a malicious version with the
same SHA-1, we (well, the user) are in trouble. If the user uses this
repository directly then the malicious object can be used without
detected, even if it does not match the original SHA-1, as we do not
always verify content against its SHA-1 for common commands.
-- 
Duy
