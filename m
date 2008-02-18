From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 1/5] Add platform-independent .git "symlink"
Date: Mon, 18 Feb 2008 09:35:27 +0100
Message-ID: <8c5c35580802180035q3d914720x54aa7e32d6e82108@mail.gmail.com>
References: <1203286456-26033-1-git-send-email-hjemli@gmail.com>
	 <1203286456-26033-2-git-send-email-hjemli@gmail.com>
	 <7v7ih2u8e1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 09:36:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR1Tt-0005pe-Di
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 09:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbYBRIf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 03:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754430AbYBRIf2
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 03:35:28 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:63405 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250AbYBRIf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 03:35:27 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2681143wah.23
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 00:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Iw86ILcU93BSPm0y9WsnIEKJ9J8Bfqb18XfzGfTm74U=;
        b=cXipit1/vTVeS7LkiQCzEqVYklZIEvr+kLlZ6uYQTB8UDgKGOQatRjO328QzoL2rsRGroh/HRsTfF2Alz4hJAecukkfbVR+vZ/HIkId24gVu99El15TppMM/g/iF5ZGpb7WZ+ysKzh0HzqmeT38ezHJroC98eH5Lc+RM4vXGWBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZYitg/LiohxCyPXXJMPNPFt/QBGPmvAPJZpybUJnThF1ZoN9TethvASD6+DmZiYojEYxK4wta5g2OY9fQYFgZYlmEpb/B+h8jYrxiuZpfywl4+fsBnxQ2Iy6c5FhoZ5Db9tbVKp290/QnhYxDmmGWp8qSDvRoQjgXG9ZZyGiuKg=
Received: by 10.114.120.1 with SMTP id s1mr1548343wac.125.1203323727369;
        Mon, 18 Feb 2008 00:35:27 -0800 (PST)
Received: by 10.115.92.8 with HTTP; Mon, 18 Feb 2008 00:35:27 -0800 (PST)
In-Reply-To: <7v7ih2u8e1.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74242>

On Feb 18, 2008 6:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
> > This patch allows .git to be a regular textfile containing the path of
> > the real git directory (formatted like "gitdir: <path>\n"), which is
> > useful on platforms lacking support for real symlinks.
>
> I think a sane simplification is to allow the file to have
> any number of optional \r or \n at the end.

Agreed.

> > +     len = read_in_full(fd, buf, sizeof(buf));
> > +     close(fd);
> > +     if (len != st.st_size)
> > +             return NULL;
> > +     if (!len || buf[len - 1] != '\n')
> > +             return NULL;
> > +     buf[len - 1] = '\0';
> > +     if (prefixcmp(buf, "gitdir: "))
> > +             return NULL;
>
> But I am not sure about this part.  We found what claims to be
> the ".git" fake symlink but it is ill-formed.  Don't we want to
> diagnose the possible breakage for the user?

Yes, I think I got to eager in my 'gentleness'. It's probably better
to die() with an appropriate errormessage.

>
> > +/*
> > +     if (!is_git_directory(buf + 8))
> > +             return NULL;
> > +*/
>
> Likewise.

True, I'll uncomment and die().

Thanks for the review.

--
larsh
