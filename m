From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 11/44] refs.c: change ref_transaction_create to do
 error checking and return status
Date: Thu, 15 May 2014 15:02:39 -0700
Message-ID: <CAL=YDWnDFxJjHTXzFu9bGVQRTohs4nP-49eXObOQEcEykzmmJw@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-12-git-send-email-sahlberg@google.com>
	<20140515194456.GI26471@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 00:02:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl3jg-0007nK-Kv
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 00:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbaEOWCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 18:02:41 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:58165 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333AbaEOWCk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 18:02:40 -0400
Received: by mail-ve0-f174.google.com with SMTP id jw12so2101362veb.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 15:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yJwSe+xh+NDE3RkBGfBmsQj9YK5CqTomab1LnJ7gi24=;
        b=XOYawK7ByKofBaWPqsYefMNNm828Qp6aXZ/TnlUnoSXTGhlmKn/RFFHpZn+LYtA4Cr
         z5xSDNDVTyWLOmCPduu1cndA7vOYN7i4JreHcOFD3TC2kzZQC6RV/qE3pfRYQ3AWq3w0
         1qC2S5ycWWth/fStyiLCodQlfllTKhXD/3BFCtTCIOQeRhc0kzxTXd4rOA2Zd+tgemQW
         ir8OKOyZDwL7yeq1w02HVLvGVGg1gbxClqTy/Pk0XgvXTBaJqFoDw9YWxkjYaHVs8tSf
         eSNPdRFcse8kZuSDA/QJLBBMBWXlWqrhLYSFcQD/i1/VuLNKhQOIWU2aKV0wbLKzk29O
         d/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=yJwSe+xh+NDE3RkBGfBmsQj9YK5CqTomab1LnJ7gi24=;
        b=heTc95s+b+mUgHAfj0WVVtV/kZF58U0CU5A5qpWEulo4szwC97Lpc4TBhRsaYUXjrv
         0r+RpTta2oCh/NqGqKaL9dxTBKcQgQvPf4YVV2U/L4ALzGY+gVCNY/R3g45EJQ5+NCmt
         y0RJT5eb3W99sAbnNFD7fMX/nNUH5p4erehL3pT1PrjoM8U6hggfFFJXTH+UYX61+RQ8
         HCwt1NLR5wvax1AixZOTflTedDdlp5KXZQx0+hpq8ruCR5Du7wnLHB84wJh4lKYVYxgg
         eldutbex9d3oZqgCHxUshetq5XJUuNSbOLok6Vq0/3pO5D7qYqls2/J85SAhB18OhqEq
         DEgA==
X-Gm-Message-State: ALoCoQlXYzWz3SiQFlcu8uYJNCUjQv/gkHtkl1EUjRbQkn8dOUQNhrn4QP5eLzbwQrb6vbFIiIaG
X-Received: by 10.52.12.36 with SMTP id v4mr9001997vdb.20.1400191359583; Thu,
 15 May 2014 15:02:39 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 15 May 2014 15:02:39 -0700 (PDT)
In-Reply-To: <20140515194456.GI26471@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249208>

On Thu, May 15, 2014 at 12:44 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Do basic error checking in ref_transaction_create() and make it return
>> non-zero on error.
>
> Same thoughts as _update().  Basic idea is good but would be nice to
> have a 'struct strbuf *err' parameter.

Done.

>
> Thanks,
> Jonathan
