From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: large files and low memory
Date: Tue, 5 Oct 2010 17:59:34 +0700
Message-ID: <AANLkTik1kzzzOKFaJCWtwiYf5Vz8oNjZXD+-SAq-ZvAa@mail.gmail.com>
References: <20101004092046.GA4382@nibiru.local> <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
 <20101004185854.GA6466@burratino> <AANLkTin-mbzt93DWtp71vYBEUcDLHgo=G-6zynT5NC_r@mail.gmail.com>
 <20101004191657.GC6466@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>, weigelt@metux.de,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 13:00:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P35FZ-0004ww-Ty
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 13:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810Ab0JEK74 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 06:59:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39253 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab0JEK7z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 06:59:55 -0400
Received: by wyb28 with SMTP id 28so5876839wyb.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 03:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=FYPkUs90iW8nyfg/0umQ64e3+VrV8EEEb5u3RFMPc7o=;
        b=oKRCefCD23aQiWLr/1icRNQVKF+yp9y7KxxYmTJgmCJUM6ObjfaD9l5YQqZ/6emNRa
         DY3LkF5pTZ6cFsyt7uZ8yVYwjasE8AAfBekx9ijbZAzL68q9qjqfJNXTrUoNBWGQE10V
         GkAvmInprcNIi6FAlmGGyklzdmfTpscRfYlYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cUZu7LRr/cL5OLXp9LgwruQrlKfvIV5Z3UzBAK7g0gWBe5umWeXvu3rwv358eqUQiE
         oskbhK9R7Pdz3j1JZ/OdgV0BGvZz7SPerE6HsSQig/Ok4F2+C9mAc3bxbVIrPNzLpxH3
         cuD4XYqMEfCD9oBABcZTlZrQkYqR+M9jckSl4=
Received: by 10.216.30.10 with SMTP id j10mr873660wea.8.1286276394522; Tue, 05
 Oct 2010 03:59:54 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Tue, 5 Oct 2010 03:59:34 -0700 (PDT)
In-Reply-To: <20101004191657.GC6466@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158185>

On Tue, Oct 5, 2010 at 2:16 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Shawn Pearce wrote:
>
>> This change only removes the deflate copy. =C2=A0But due to the SHA-=
1
>> consistency issue I alluded to earlier, I think we're still making a
>> full copy of the file in memory before we SHA-1 it or deflate it.
>
> Hmm, I _think_ we still use mmap for that (which is why 748af44c need=
s
> to compare the sha1 before and after).

Just tried valgrind massif on a 200MB file with master. It used ~270kb
heap. I haven't tested but I believe git-checkout will keep the whole
inflated copy in memory. So git-add alone does not help much.
--=20
Duy
