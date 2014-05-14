From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v6 04/42] refs.c: make ref_update_reject_duplicates take a
 strbuf argument for errors
Date: Wed, 14 May 2014 08:24:48 -0700
Message-ID: <CAL=YDW=pN=L0v2RsiaanuAOR==_RENX0xnbwnWbJXKfih_oeVQ@mail.gmail.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
	<1398976662-6962-5-git-send-email-sahlberg@google.com>
	<20140514000402.GZ9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 17:24:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkb37-0003Ky-TN
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 17:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861AbaENPYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 11:24:50 -0400
Received: from mail-ve0-f169.google.com ([209.85.128.169]:61305 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295AbaENPYt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 11:24:49 -0400
Received: by mail-ve0-f169.google.com with SMTP id jx11so2580876veb.14
        for <git@vger.kernel.org>; Wed, 14 May 2014 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lvelrP/+6J2gh2wzgFgULBSh/G/lVOtGk/NmKhorQOU=;
        b=kdQcIqMUPNNy3MNaSPbCfqaj78A0+AKkDxpj12MkHP1uN4R76XHDvQHCGJ5rHdz5Nq
         /V1xlfoqWm/sKNmyKDPbogiqjrdwNqMDu1EFUX2vc69vBlqp4LWogHGa4uBhRSIhbHCe
         abIdRP/tGYjnHfqExya0WeKNQcoroFQ7SO6fban8zCRd4iSLpBHHZ1Ui2lEFSmiV4zaZ
         a5yp3vBgwGZMcetTeD0OmdQn+f48WO6uVi2a/MKoAwGd0WTmfuhJrdzIw8WXflh2caKX
         kdtkGyFFR+JEVbiwNbFh1v/6EfN6LZ3wYkcAq4qm1W0vSEF0i8M76+YRDmswRptDGJ/4
         VzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lvelrP/+6J2gh2wzgFgULBSh/G/lVOtGk/NmKhorQOU=;
        b=EKX86zuUK18Kksczu9OeEVA/qswKbv0vPZMNUe5shqlAUgknnxUcp3tyaNdrGGBozf
         Mp8u6Pjt+fzrRgHCbl5e6nYoMtsi12xWM5NkoqLcvWfjefTdxf0N2hIxwc10nNQsWDaO
         sU701nx2xK0OuoMfC3JcCccjwg+a0qKKMrhYgnJsrf7pqM/lkNs8WftTQsCPOlLpn/gH
         MF23YlBKubyWK9zCZAvECghse1dcfamJpl1VTwArg1HyqG/AtI87NIJxSB8mbNShK+QF
         fI8x4HbEuUqjjnYD4X60w6q2PVa5O4s6SgitEppEBpWMYrgjjd94q3Fm/ICa28n0r9TB
         4Zvg==
X-Gm-Message-State: ALoCoQlkFhBuWbvcxmLFqAiti0vFbgeyllT0RyWYBtaJ0y52eY+G7FHlFbE6wm4SybWKbA+MiTZp
X-Received: by 10.58.66.195 with SMTP id h3mr340981vet.57.1400081088788; Wed,
 14 May 2014 08:24:48 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 14 May 2014 08:24:48 -0700 (PDT)
In-Reply-To: <20140514000402.GZ9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248920>

Thanks.

I updated the commit message to highlight that this means the error
string can now be passed all the way back to the caller.

On Tue, May 13, 2014 at 5:04 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Make ref_update_reject_duplicates return any error that occurs through a
>> new strbuf argument.
>
> Sensible.  The caller-visible effect would be that now
> ref_transaction_commit() can pass back a helpful error message through
> its "err" argument when asked to make multiple updates for the same
> ref.
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
