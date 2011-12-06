From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Set hard limit on delta chain depth
Date: Tue, 6 Dec 2011 22:45:12 +0700
Message-ID: <CACsJy8AZg3DgZzmPyXhCH9bGBqo9UN7-zLt_feTtpyajf5U1tw@mail.gmail.com>
References: <1323068688-31481-1-git-send-email-pclouds@gmail.com> <7vvcpthh97.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 16:45:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXxDK-0007Ki-SY
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 16:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464Ab1LFPps convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 10:45:48 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38150 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab1LFPpr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 10:45:47 -0500
Received: by eeaq14 with SMTP id q14so3019493eea.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 07:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XywOwrrEiGQk4mPXSUILru3FmHQJa0eS5Yo77zCb6dg=;
        b=BOFsKKr72bHH0cREEjfk88ZSHm3mJiJePjRfEoEC2QS4S3V2rcl41pEHpYjHr+VkiD
         gwY5oV/DQ6WLwVtxCSRud2WuEx0UWh724BcfWU3j5yWNIa99dSfgshJQeNS3WHUJGQit
         mM9EQ/HHjEn5lKNI75QisFjhA36e8wf1odDN0=
Received: by 10.14.17.155 with SMTP id j27mr2613435eej.195.1323186343218; Tue,
 06 Dec 2011 07:45:43 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Tue, 6 Dec 2011 07:45:12 -0800 (PST)
In-Reply-To: <7vvcpthh97.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186353>

2011/12/6 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> Too deep delta chains can cause stack overflow in get_base_data(). S=
et
>> a hard limit so that index-pack does not run out of stack. Also stop
>> people from producing such a long delta chains using "pack-object
>> --depth=3D<too large>"
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0I used to make very long delta chains and triggered this in in=
dex-pack.
>> =C2=A0I did not care reporting because it's my fault anyway. Think a=
gain,
>> =C2=A0index-pack is called at server side and a malicious client can
>> =C2=A0trigger this. This patch does not improve the situation much, =
but at
>> =C2=A0least we won't get sigsegv at server side.
>
> Why should we treat this condition any differently from the case wher=
e the
> sender of a pack used beefier machine than you have and stuffed a hug=
e
> object that the index-pack running on your box cannot hold in core,
> causing xmalloc() to die on your machine?

That's interesting. First of all xmalloc() is controlled by us while
index-pack code might lead to stack overflow exploit (never done it,
not sure if it's really pratical to do in this case).

But can I really use up all memory at server side by sending a huge pac=
k?

> I do not think this is the right way to handle the issue. Your other =
patch
> to flatten the recursion to iteration looked a lot saner approach.

It may take me some time as I'm not really familar with this code.
Anybody is welcome to step up and flatten the function.
--=20
Duy
