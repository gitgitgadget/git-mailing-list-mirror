From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v4 3/4] cache-tree: fix writing cache-tree when CE_REMOVE
 is present
Date: Sun, 16 Dec 2012 17:15:48 +0700
Message-ID: <CACsJy8DgwQ2jn=tPpE8f22JNE1Vih86d=Xf1iGBznLcwMukd+w@mail.gmail.com>
References: <1355631328-26678-1-git-send-email-pclouds@gmail.com>
 <1355631328-26678-4-git-send-email-pclouds@gmail.com> <7vk3siqx8b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 11:18:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkBIJ-0002JB-Db
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 11:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab2LPKQU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Dec 2012 05:16:20 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:56205 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378Ab2LPKQT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Dec 2012 05:16:19 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4989079oag.19
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 02:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JWhfa0ZiEMRTsBfjdxQkyAJaxRnbr042LqbgbvPhW2c=;
        b=sVqFIRqc3dSpwNJs4Z12AMhk8Bix5Bu5yyi8rgoPTJSoVlcuCdPjQkfRjb12FDBcG/
         pAErOm+GCkcyZ9s6rhG6wtTv4G6HMxyNwXNFedZT8tSVnuUlLDLCk0UqoryPxkfzsz54
         c5yJ+WOKj0bpeOkZa+kkVvbn9APF5TyKVqXWM6+/CYv+xBSoUwjSAIkYxWptZ746kWrB
         lHUleFrlao4jxPlrVkt59klcrLN9v/jnbVVicVk+umOqrJNRDkxN2LRh6vv4n5GSpm0+
         SR2NVhunMDux8dImx2Gm+kgNOgCuEF52qJwgZqZFoZFGk3o8urh5CuKpPV07HQ7KEvX2
         RkbQ==
Received: by 10.182.18.142 with SMTP id w14mr9086208obd.65.1355652978445; Sun,
 16 Dec 2012 02:16:18 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Sun, 16 Dec 2012 02:15:48 -0800 (PST)
In-Reply-To: <7vk3siqx8b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211587>

On Sun, Dec 16, 2012 at 2:20 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> entry_count is used in update_one() for two purposes:
>>
>> 1. to skip through the number of processed entries in in-memory inde=
x
>> 2. to record the number of entries this cache-tree covers on disk
>>
>> Unfortunately when CE_REMOVE is present these numbers are not the sa=
me
>> because CE_REMOVE entries are automatically removed before writing t=
o
>> disk but entry_count is not adjusted and still counts CE_REMOVE
>> entries.
>
> Nicely explained.  I wonder if we can also add a piece of test to
> the patch 4/4 to demonstrate the issue with CE_REMOVE entries,
> though.

A hand crafted one, maybe. I did not attempt to recreate it with git
commands (and I don't think we update cache-tree after unpack_trees).
So I wrote something like this instead:

int main(int ac, char **av)
{
	unsigned char sha1[20];
	setup_git_directory();
	read_cache();
	active_cache[1]->ce_flags |=3D CE_REMOVE;
	write_cache_as_tree(sha1, 0, NULL);
	return 0;
}

I can polish it a bit and write new tests based on it and
test-dump-cache-tree if you want.
--=20
Duy
