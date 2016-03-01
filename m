From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v7 31/33] refs: add LMDB refs storage backend
Date: Tue, 1 Mar 2016 08:31:05 +0700
Message-ID: <CACsJy8AUqB_1XZweTmAV4atDeUWZJhzEJoY2t9nJqp3CNcViXA@mail.gmail.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com> <1456793586-22082-32-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 02:31:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaZA4-00014i-NU
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 02:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbcCABbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 20:31:37 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35224 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbcCABbg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 20:31:36 -0500
Received: by mail-lb0-f172.google.com with SMTP id bc4so90565704lbc.2
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 17:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q/Nl1CkUgoZmKMSnHoCiOkKAJdlONHInKjo6CnM/1Rg=;
        b=q+WvycgdhvF1y57Yj07mKqou+gcdMPSU7zAXhLbCTRYj8oJksSv4w8rNCECYQpx5d3
         FJhlXeYnWZ7Euh3uthiSn1KAzSh+QRyvZYOibQ1NKwunBDEjVPwsTlu5QWSOr7REPdqZ
         GMNZjLaWa24mnsddBO0Nx9IaL60OsW+UcCXD5TPquHlzC0ckcmesdDlVUa09fxEuT3h/
         rCJB8cVKaezbXAUxnpJ8DhSfZmt6YTQSZq4NwZE1y0vzXB9JyYZ/R7ecmMW+ur17e6q8
         bG4iWXrMIX2/1jJylLy6e6kvie4j3PT2abXqbs7vVLlcGguuJB3H6XBiuiQMwbLXbS2S
         /rZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q/Nl1CkUgoZmKMSnHoCiOkKAJdlONHInKjo6CnM/1Rg=;
        b=bVT7MinamBgiutq07VT/54g3Jpi2xy5bc1EMrfULK5ohMqNAaEMSyyWxyCcoUswU9g
         6jy0VdibaRpDUKZd5synF7AFeIgiHEFkmW+sQexce8xta7i8VTKxjgcouyo0x0EqXENW
         RENGcGuC51mXHsrv3zcFrQuopddhwcXRuqqTkQwE6BWkENoqyF0xVcqZYCIyS/85Hog2
         bjyfiBnDxoiwXhtd+gt2yo9F4PnE71qCQO6zCcExzKqTT0gW28MmhyWbjfVmC+ZzvHKo
         Jg96yUp602EQAYfk8Agzk0+J1XMdRMtAzK6Z9EiMwc7eL2DIC1JByvzlg5wqcrUvpazE
         2ivw==
X-Gm-Message-State: AD7BkJJ8PVMghLqxw20bldWgTuBXtpuodri+7zwzqFNGA6pi/E2W1qRuzlMzxGK8caLrs48OtjHDBrlAiaCzhA==
X-Received: by 10.112.166.68 with SMTP id ze4mr6688400lbb.137.1456795894971;
 Mon, 29 Feb 2016 17:31:34 -0800 (PST)
Received: by 10.112.51.99 with HTTP; Mon, 29 Feb 2016 17:31:05 -0800 (PST)
In-Reply-To: <1456793586-22082-32-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287979>

On Tue, Mar 1, 2016 at 7:53 AM, David Turner <dturner@twopensource.com> wrote:
> +Weaknesses:
> +-----------
> +
> +The reflog format is somewhat inefficient: a binary format could store
> +reflog date/time information in somewhat less space.

This raises an interesting question. What if we want to change lmdb
format in future (e.g. to address this weakness)? Do we need some sort
of versioning in lmdb database? I suppose you can always add "lmdb2"
backend that shares most of the code with current lmdb backend. Not
sure if that's what you had in mind though.
--
Duy
