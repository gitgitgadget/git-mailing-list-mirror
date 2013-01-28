From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 6/7] read-cache: refuse to create index referring to
 external objects
Date: Mon, 28 Jan 2013 12:57:15 +0700
Message-ID: <CACsJy8CXC=poDBenBwo6t8=Qv-_zvGbvHYo-cDdGA8_fpw4Cyg@mail.gmail.com>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
 <1359016940-18849-6-git-send-email-pclouds@gmail.com> <7vpq0ubdec.fsf@alter.siamese.dyndns.org>
 <CACsJy8C3tLOHCK4Qc--W630do0M=xLKSMoYUxxv2_GDaUXaRww@mail.gmail.com>
 <7vpq0t3x60.fsf@alter.siamese.dyndns.org> <CACsJy8BJZgyEn1n2GWgAVSGhSkVUO-P=GXwR02OcDf0ziTTRaA@mail.gmail.com>
 <7vy5fdyhs0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 06:58:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzhjN-00005d-8n
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 06:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827Ab3A1F5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 00:57:48 -0500
Received: from mail-oa0-f52.google.com ([209.85.219.52]:64143 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab3A1F5r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 00:57:47 -0500
Received: by mail-oa0-f52.google.com with SMTP id k14so1594846oag.39
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 21:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=pM+pX5liaOwFVdOyskV2NI59oqhf0OhrvIUX97Sb2gA=;
        b=DHm8MIDP9LvixtpCGRnJYmAE4RyjePblFbL9n/Tm6lunk0EJVU10U5bPp4jbJtTvWX
         +I8ZPNp9Mzj05gQTaxN2kCsrpQq5FtHqo6xUVZrCNj2TUbnAlJz2crD0dkaGcIHejEYx
         ejTQYwokCab7yz2VRYKDoeC8JON0eh42MlH7WA33inVoiEhlQtGXVTppcabkOV/qVC1c
         V6JesTmd0G4+mRaxFhDHpKPYR4iJrFqptuV9OuZjg/PZ52RNnDe7m6E/zLysHpwwrLAc
         QYFYubiibIsVmh0BoAVgsfgYuqPvJqmlKmfPlygurFJ8glKw1DIbzhOLcFJtH2cyO88o
         ZR6w==
X-Received: by 10.60.32.44 with SMTP id f12mr10654241oei.61.1359352665786;
 Sun, 27 Jan 2013 21:57:45 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Sun, 27 Jan 2013 21:57:15 -0800 (PST)
In-Reply-To: <7vy5fdyhs0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214809>

On Mon, Jan 28, 2013 at 12:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sat, Jan 26, 2013 at 2:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> This is not a tangent, but if you want to go this "forbid making our
>>> repository depend on objects we do not have but we know about after
>>> we peek submodule odb" route [*1*], write_sha1_file() needs to be
>>> told about has_sha1_file_proper().  We may "git add" a new blob in
>>> the superproject, the blob may not yet exist in *our* repository,
>>> but may happen to already exist in the submodue odb.  In such a
>>> case, write_sha1_file() has to write that blob in our repository,
>>> without the existing has_sha1_file() check bypassing it.  Otherwise
>>> our attempt to create a tree that contains that blob will fail,
>>> saying that the blob only seems to exist to us via submodule odb but
>>> not in our repository.
>>
>> Another thing needs to be done for this to work. The current reading
>
> For *what* to work???

The "forbid making our repository depend on objects we do not have but
we know about afterwe peek submodule odb"

> I think the performance consideration is the
> only thing that should drive the read-order; correctness should not
> be affected.
>
>> order is packs first, loose objects next. If we create a local loose
>> duplicate of an alternate packed object, our local version will never
>> be read. Regardless the submodule odb issue, I think we should prefer
>> reading local loose objects over alternate packed ones.
-- 
Duy
