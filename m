From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] remote-hg: add shared repo upgrade
Date: Fri, 9 Aug 2013 15:24:10 -0500
Message-ID: <CAMP44s3KkwWnTb7=w-oviGRrsXk+g_L0yL9=xyywSpobmeExOw@mail.gmail.com>
References: <1376078581-24766-1-git-send-email-felipe.contreras@gmail.com>
	<1376078581-24766-3-git-send-email-felipe.contreras@gmail.com>
	<CALWbr2yAitLSNGj2qwz4C8Ugm8wHnGTf4ndZSbPcFToczWaWEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	=?UTF-8?Q?J=C3=B6rn_Hees?= <dev@joernhees.de>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 22:24:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7tEO-0006bC-AA
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 22:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031018Ab3HIUYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 16:24:12 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:62548 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030994Ab3HIUYM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 16:24:12 -0400
Received: by mail-lb0-f171.google.com with SMTP id t13so3447883lbd.2
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 13:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=s37lGq/qjBoyBvxo3Jhn5WXJ4FGFt8pk02Pwi6Y1nag=;
        b=ez53FUz8JOcs3FetEuMiCWdUkknsFQZKv91Z3G5I102aevyydSbV6vD7sC0o4dcyjn
         YCcq/ANdRfQ28fyTCCePshVI6Gm6elBTiV31POpXrZenn0MeQvKmH4sg8RhhYx/oMINE
         D2K4LXiUISDGQPI4W1IFNXTUFTKva/Kz523Ujg1cv2/8C7GccN2P+IykZ6mjrzX4tisV
         W52MCnC7uhMPrShafNycm94gRUxkRNXozGkw2VHsSoGgr3Rwpv+GLMAJgDPPtgJsN4fX
         gbkha4rHQm6P4G/12sDOCWa3fbO/OkSzCtcAImKi0ZvB7Y/t4DsbMtrwJqZriIJ6wmJ+
         Pbhg==
X-Received: by 10.112.63.132 with SMTP id g4mr5260042lbs.25.1376079850382;
 Fri, 09 Aug 2013 13:24:10 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Fri, 9 Aug 2013 13:24:10 -0700 (PDT)
In-Reply-To: <CALWbr2yAitLSNGj2qwz4C8Ugm8wHnGTf4ndZSbPcFToczWaWEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232026>

On Fri, Aug 9, 2013 at 3:19 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> On Fri, Aug 9, 2013 at 10:03 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> 6796d49 (remote-hg: use a shared repository store) introduced a bug by
>> making the shared repository '.git/hg', which is already used before
>> that patch, so clones that happened before that patch, fail after that
>> patch, because there's no shared Mercurial repo.
>
> Does that still hold ? You are creating the shared_path repository
> just below, so it should work without the patch.
> The real reason for this patch is to avoid having to re-clone from a
> potential slow source, is it not ?

Yeah, that's true.

>> +        # check and upgrade old organization
>> +        hg_path = os.path.join(shared_path, '.hg')
>> +        if os.path.exists(shared_path) and not os.path.exists(hg_path):
>> +            repos = os.listdir(shared_path)
>> +            for x in repos:
>> +                local_hg = os.path.join(shared_path, x, 'clone', '.hg')
>> +                if not os.path.exists(local_hg):
>> +                    continue
>> +                shutil.copytree(local_hg, hg_path)
>> +                break
>> +
>
> By the way, I liked my version better, that is:
>
> if os.path.exists(local_hg):
>     shutil.copytree(local_hg, hg_path)
>     break
>
> Simplifying the if not condition: continue else: break

I prefer my version because if there's any need to add more lines,
they don't have to be indented. That's why a lot of code ends up
having unnecessary indentation.

-- 
Felipe Contreras
