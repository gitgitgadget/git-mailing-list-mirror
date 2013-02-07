From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] count-objects: report garbage files in
 .git/objects/pack directory too
Date: Fri, 8 Feb 2013 06:58:24 +0700
Message-ID: <CACsJy8DaHanuPxeHv5GNqomE4=XtnyyJDepoVP8PmY88t4Au=Q@mail.gmail.com>
References: <1359982145-10792-1-git-send-email-pclouds@gmail.com>
 <1359982145-10792-2-git-send-email-pclouds@gmail.com> <7v1ucw2bd4.fsf@alter.siamese.dyndns.org>
 <20130207073751.GA20672@duynguyen-vnpc.dek-tpc.internal> <7vzjzg802d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 00:59:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3bN9-0005WM-JK
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 00:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572Ab3BGX64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 18:58:56 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35994 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab3BGX64 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 18:58:56 -0500
Received: by mail-ob0-f176.google.com with SMTP id v19so3341066obq.35
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 15:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=kAtW43LuCvnUjQaZt9GyGGOCJdu6sEqQUoCJ++gHZDo=;
        b=KmCAmd0xuuEo1DKRb3SZMZE1hbLxPbnv5BzuX6LNK75a8AJvH5ZhrL1wGsCXwIt3qx
         4DWj30xTaZxEdWpnWgG8uIxrYD/4EGUciTI8rpDwiWSLwLUoBPyTGiaAlJ0EXITkJBcq
         7FJ/oTjVF86zeWpkp1ICKlsqhkTcsUOzveXY0aKU2fL7/sIgBCOhgiRRu6LY9xl2jonr
         fUTehXXqGFGzgQ7BMLRfX0nZyosXtGDPaH+sZ/FSsuuJ01ssidpel6p/PhXGbVXxBulk
         ocszwP7WnkSQpV85Ujp+CzvfGoVRo32xpomdCnka0wThrcbFAebyU580P4abNxfK3NFG
         hNSQ==
X-Received: by 10.60.7.167 with SMTP id k7mr2792808oea.20.1360281535403; Thu,
 07 Feb 2013 15:58:55 -0800 (PST)
Received: by 10.182.129.46 with HTTP; Thu, 7 Feb 2013 15:58:24 -0800 (PST)
In-Reply-To: <7vzjzg802d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215738>

On Fri, Feb 8, 2013 at 1:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> I thought about that, but we may need to do extra stat() for loose
>> garbage as well. As it is now, garbage is complained loudly, which
>> gives me enough motivation to clean up, even without looking at how
>> much disk space it uses.
>
> I wouldn't call a single line "garbage: 4" exactly *loud*.  I also
> think that this is not about *motivating* you, but about giving
> more information to the users to help them assess the health of
> their repository themselves.

That's not the only line it prints:

error: garbage found:
.git/objects/pack/pack-8074dfd2b01f494a30f02d0374baa57632d26fea.commits
error: garbage found:
.git/objects/pack/pack-834c9dccca7634c2b225db1b5050a980cb2c2de0.commits
error: garbage found: .git/objects/pack/tmp_pack_G235da
error: garbage found:
.git/objects/pack/pack-8bdf298e9252573289cd4f1e83e80c9f261882a2.commits
count: 604
size: 5576
in-pack: 172307
packs: 4
size-pack: 50421
prune-packable: 4
garbage: 4

> By the way, I wonder if we also want to notice .git/objects/garbage
> or .git/objects/ga/rbage if we are to do this?

I prefer not (for code simplicity) because we may need to catch
.git/objects/pack/info/garbage too if we do that.

>> +                     if (!has_extension(de->d_name, ".pack")) {
>> +                             report_pack_garbage(path, 0, NULL);
>> +                             continue;
>> +                     }
>
> Didn't I already say the logic should be inverted to whitelist the
> known ones?  Saying "Anything that is not '.pack' is bad" here is a
> direct opposite, I think.

I must have missed it. Will do.

>
> Add "A '.keep' file is OK" to this codeflow and see how it goes.

OK
-- 
Duy
