From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] Perform cheaper connectivity check when pack is used
 as medium
Date: Tue, 6 Mar 2012 18:20:21 +0700
Message-ID: <CACsJy8A+c6t_zHziPcQZ-Nw+fm0TmaG8VmDfnoPf-DzHHm8QVA@mail.gmail.com>
References: <7vmx849ma8.fsf@alter.siamese.dyndns.org> <1330435109-4437-1-git-send-email-pclouds@gmail.com>
 <7vwr73h6td.fsf@alter.siamese.dyndns.org> <CACsJy8D7JB9bzOvammGAx1rW04DEUCVzvfp-_Q1KtE9G00rZVQ@mail.gmail.com>
 <7v1upagb8z.fsf@alter.siamese.dyndns.org> <CACsJy8B7u-rvnFZKi4t2CoB=J3Ra8pWxK4439NTdnHQDhm2ibQ@mail.gmail.com>
 <7vfwdq8914.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 12:20:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4sRt-00012g-HG
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 12:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759075Ab2CFLUx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 06:20:53 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:57871 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759063Ab2CFLUw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2012 06:20:52 -0500
Received: by wibhm2 with SMTP id hm2so2548225wib.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 03:20:51 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.216.134.200 as permitted sender) client-ip=10.216.134.200;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.216.134.200 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.216.134.200])
        by 10.216.134.200 with SMTP id s50mr5705993wei.116.1331032851494 (num_hops = 1);
        Tue, 06 Mar 2012 03:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kyPL5tnP5UqIj1NZ4FAZ+Wt4PZ6aGUtLCr5SSAF0srM=;
        b=qGC5mKt/z4UMtEswcVFanUA2gxTAACwosz73AekClq7Cbc3sYEAshjMx+WfvQWEEic
         YQLnxLogvZnPZzRjMniUCMGPixZ6SeO23/5fySAlv5F67RHsw8w3KeTzEIH5ElRAS9/x
         JL8isnX22tG1F/dYTCMPZqSVNFXMKKNUM8WVsn9bGWaNlp88rcZSS8iRUa3ezKm50R8o
         s9epcZ8GLQsw05hFnFkvRcVkV51ugBvH/sZMXZNYV/eplK+t97yppDbRA/XgJ8CmDZcP
         WyoDpgp23p7fWnhku+OvpA787CK7MxJjKMaHOiD+x/2JPc8F78WJEgPs389yZ3OwS07T
         92Dw==
Received: by 10.216.134.200 with SMTP id s50mr4586515wei.116.1331032851420;
 Tue, 06 Mar 2012 03:20:51 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Tue, 6 Mar 2012 03:20:21 -0800 (PST)
In-Reply-To: <7vfwdq8914.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192333>

On Sat, Mar 3, 2012 at 1:59 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> But now you brought it up, I think we may also need to worry about a
> corrupt pre-existing loose blob object. =C2=A0In general, we tend to =
always
> favor reading objects from packs over loose objects, but I do not kno=
w
> offhand what repacking would do when there are two places it can read=
 the
> same object from (it should be allowed to pick whichever is easier to
> read).

Corrupt accidentally or on purpose? If some one can add a few corrupt
loose objects to your repository, (s)he can also put a pack with a
corrupt index (e.g. sha-1 does not point to the content that matches
that sha-1) there too. If that corrupt pack is chosen for reading at
"repack -ad" time, I think pack-objects would happily copy over
whatever the index points to. And the new index that pack-objects
generates (i.e. not through index-pack) may be also corrupt.
--=20
Duy
