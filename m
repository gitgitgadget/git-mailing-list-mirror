From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 03/19] read-cache: allow to keep mmap'd memory after
 reading
Date: Wed, 09 Mar 2016 19:09:08 -0500
Organization: Twitter
Message-ID: <1457568548.13557.13.camel@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
	 <1457548582-28302-4-git-send-email-dturner@twopensource.com>
	 <xmqqziu7fe6u.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 01:09:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adoAH-0007TK-Et
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 01:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933581AbcCJAJN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 19:09:13 -0500
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36309 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbcCJAJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 19:09:10 -0500
Received: by mail-qg0-f52.google.com with SMTP id u110so57063799qge.3
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 16:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=7nvfMTR1uBBjhQs79DD1pvYMNvmE/h7ZvqAc6zaMS20=;
        b=WH+lXi4ShLqc8lyPu9cqfaK66lRAfd1WpnlcINbP6CKpKWJgCpqH0iwKYfD3IWhsCM
         A7bdMSgvvVx5ns7fE8Mie/irYERkNe3WGvFHYiY56UAGoEy6LdLqiVX8j8pG7bdtBOdT
         Mu7pCgipvrrjETQWgJgrsb8kGBmGZUCWLNNPSapg4rU+8GN4M4eo3TNIBTxuMy4p5kOX
         9JqjLMkgr3Yi6bR89Z3Vka3xHVFeXQ7NSBLID3fdc9V4kf9l8METtxXZ+IDFeaaESBBR
         ucuflUqH9BCCW43cVByzoz3O/BA+fmjTZ41FlM6+5nBaM2XKDNkAloj3Csd5wIx0esrt
         y5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=7nvfMTR1uBBjhQs79DD1pvYMNvmE/h7ZvqAc6zaMS20=;
        b=FTQsHNY3DQRNoX6ciqJRuNVMv4VbFv+qdeJJL8Eu/vhA626d5f21s2+ztPabQAJg/I
         rfHtRu/DENceA/jIaMgNOIBhXKpR1D2ydqldR19npEzJ7ZdDYhjinu1Q4CAx8rv/a+qC
         qCI3dWKBvyq8dCIHQuM3B5aTiL9zNRwwO2DuBQOSH7s/msId2UvZvwvGZhrD2h0z0B4E
         NDoy8DKQvPq4mdTGuglYjRvVoWg60CFkmUb2ZkfawNGx71NYmj544uXjiSg9xsI7tA/P
         aEkl3QvDTxkQ1cAzR1auB9IprvaCIH9Z8gEBu0MGAUtAXyfObEEUNIyN74PPoroP3AfZ
         zOqA==
X-Gm-Message-State: AD7BkJLgt2rt7cNK0WNUQS80OMOTQ+But4X9KdDRTJPkgnK5YjTGxYDEV00G8k5gtJSR4Q==
X-Received: by 10.140.96.85 with SMTP id j79mr650503qge.10.1457568549842;
        Wed, 09 Mar 2016 16:09:09 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 188sm560116qhi.1.2016.03.09.16.09.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 16:09:09 -0800 (PST)
In-Reply-To: <xmqqziu7fe6u.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288587>

On Wed, 2016-03-09 at 15:02 -0800, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
>=20
> > From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> >=20
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
> > ---
>=20
> As usual in Duy's patches, this one seriously lacks "why".  And also
> makes the reader wonder if the memory region is ever unmapped() and
> if so under what condition.

How about this:

Later, we will introduce git index-helper to share this memory with
other git processes.

Since the memory will be shared, it will never be unmapped (although
the kernel may of course choose to page it out).
