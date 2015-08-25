From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 3/3] untracked cache: fix entry invalidation
Date: Tue, 25 Aug 2015 15:25:01 -0400
Organization: Twitter
Message-ID: <1440530701.7859.3.camel@twopensource.com>
References: <1439702227-15453-1-git-send-email-dturner@twopensource.com>
	 <1439989286-24355-1-git-send-email-pclouds@gmail.com>
	 <1439989286-24355-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 21:25:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUJqK-0006gd-Ee
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 21:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880AbbHYTZG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2015 15:25:06 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37098 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbbHYTZF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 15:25:05 -0400
Received: by igui7 with SMTP id i7so19348412igu.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 12:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=8eeK9U5P0m0gR3A2AB4H5S+z08PvmAwmwlk9OwVhJFM=;
        b=T+ZEUkS2GwT1alUl4ZfW8QYJNNatJ7xZSolwsk4ty7Erk5jjQWvNBDAYPAEjY9Pxpx
         Su+KbX/nwPrX53a91pAvPjV0OAvdgleJ4ZJsiDE1Fw7oxBRHuyHw7Xg8Tqafxc8pvCEa
         ihxTG0VhaR/BrOas4/nVIHR913CNxVo4myxAZsFkKO1bqtXkEpuHoI1wpUVqV8+FGmoq
         C8OlwB91uqUYhggCS3zYRycw0IJJuy28ve8JIIdQcaohlJVa+vPOjDkZmaMg8T66c2w/
         9q3AnkLY4wWyovHj5IVhYHYNiT0Xe6ENtFZSmVxD/3lkauL1EjwXQq8g5upQAOcF5uoZ
         vN2A==
X-Gm-Message-State: ALoCoQnbfF1yVhudifCbOxfNytEerJPeKwqQ/uM1g0ypguEz11LhakIxvQ0cXrmRInZryrNYlKul
X-Received: by 10.50.56.104 with SMTP id z8mr5277645igp.45.1440530703954;
        Tue, 25 Aug 2015 12:25:03 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id o19sm1866869igs.18.2015.08.25.12.25.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2015 12:25:02 -0700 (PDT)
In-Reply-To: <1439989286-24355-4-git-send-email-pclouds@gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276564>

On Wed, 2015-08-19 at 20:01 +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy wrote:
> First, the current code in untracked_cache_invalidate_path() is wrong
> because it can only handle paths "a" or "a/b", not "a/b/c" because
> lookup_untracked() only looks for entries directly under the given
> directory. In the last case, it will look for the entry "b/c" in
> directory "a" instead. This means if you delete or add an entry in a
> subdirectory, untracked cache may become out of date because it does =
not
> invalidate properly. This is noticed by David Turner.
>=20
> The second problem is about invalidation inside a fully untracked/exc=
luded
> directory. In this case we may have to invalidate back to root. See t=
he
> comment block for detail.

LGTM.
