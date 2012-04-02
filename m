From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in prepare_revision_walk()
Date: Mon, 2 Apr 2012 09:51:21 -0700
Message-ID: <CAJo=hJsprQtjDChtrSMcne+OCeUx=NVxLHs3k_qnYLzO=aQWuw@mail.gmail.com>
References: <201203291818.49933.mfick@codeaurora.org> <201204021024.49706.mfick@codeaurora.org>
 <CAJo=hJshOBg4pT8nuWZ=eZvj=E9x+4b9M_EANa=02x=NFW2OfQ@mail.gmail.com> <201204021049.04901.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Shawn Pearce <sop@google.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Apr 02 18:51:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEkTw-0002QC-6w
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 18:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203Ab2DBQvo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 12:51:44 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:53040 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab2DBQvm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 12:51:42 -0400
Received: by dake40 with SMTP id e40so2679355dak.11
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 09:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Vk6QbydmEujUfiifSY8fq2mJQKcTcDXrtrDtoGSjuWM=;
        b=JUBKbbRFKWqHx0D7hQqRTYRF2MhGQop4Jo6aXjOqEfoE582WTYQVYDBZ5E/BBduMSj
         3ZcFUebUF6Tny4NMe2KV5S0nRzVWPBJOkwdGTwevWxv0XktZNZxTxt0mRRmAkgviyugl
         ziYyF64OxBAXxqz/HAfoENF8ydJTqNiG9KxJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=Vk6QbydmEujUfiifSY8fq2mJQKcTcDXrtrDtoGSjuWM=;
        b=LUEyIigk/z3dty8sKetbVeRIrUoBSP7jxqTa+uUs9ugpafNCoimibH1cRTl+3zIoA4
         b56HyneAaPyKn14+IZaBPUKwHZKwMqoehO/TX5nlOFdfDzPOgzvJgHY89erS7kjGGIbH
         nzJ49PVuqGjDap2tyAvXF+v+Y7Ppu/h//2DaLdl0660/+AejO40qeJ6fRsc0Kbdd9yK0
         t7of7HLkZaLGGzYemtjfovbCUJH5vtGLjqcNFVhz5PFuE3JWTDIPrVDMs+q3tOKu/2J9
         PLf3edWOyl3YUpn+oH8OI57O1NCaw5DkNlYDph7Lp3vgvvRFj367C/dlIXsMoDCA4C3b
         1OUQ==
Received: by 10.68.194.227 with SMTP id hz3mr22689282pbc.23.1333385501799;
 Mon, 02 Apr 2012 09:51:41 -0700 (PDT)
Received: by 10.68.237.201 with HTTP; Mon, 2 Apr 2012 09:51:21 -0700 (PDT)
In-Reply-To: <201204021049.04901.mfick@codeaurora.org>
X-Gm-Message-State: ALoCoQntR9E0wiL755Q2xG4rJioebqUkNNcJAthghnUm1mDXudP/3HsthtD9T2gOVIVAsVdGHc8s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194536>

On Mon, Apr 2, 2012 at 09:49, Martin Fick <mfick@codeaurora.org> wrote:
> On Monday, April 02, 2012 10:39:59 am Shawn Pearce wrote:
>> On Mon, Apr 2, 2012 at 09:24, Martin Fick
> <mfick@codeaurora.org> wrote:
>> > On Saturday, March 31, 2012 04:11:01 pm Ren=E9 Scharfe
> wrote:
>> Git can't really do the same thing as "cache the
>> RevWalk". Its spawning a new process that needs to
>> decompress and parse each commit object to determine its
>> timestamp so the commits can be sorted into the priority
>> queue. This is still an O(N) operation given N
>> references.
>
> While I suspect this has been suggested before, an ondisk
> cache of commits to timestamps would probably help here with
> large repos. =A0Such a cache could make even new processes
> able to create this list much quicker. =A0Since this cache
> would contain immutable data, even if it is out of date it
> would likely provided significant improvements by providing
> most of the timestamps leaving only a few to parse from
> newer commits?

Probably. But we tend to hate caches in Git because they can get stale
and need to be rebuilt, and are redundant with the base data. The
mythical "pack v4" work was going to approach this problem by storing
the commit timestamps uncompressed in a more machine friendly format.
Unfortunately the work has been stalled for years.
