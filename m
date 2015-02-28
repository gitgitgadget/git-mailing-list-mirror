From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 5/5] WIP/Document the http protocol change
Date: Sat, 28 Feb 2015 19:26:13 +0700
Message-ID: <CACsJy8DtZKAw0KibHhHAeCU3rRXCwmjWg2O68iuX-vFA=0MaCA@mail.gmail.com>
References: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
 <1425085318-30537-1-git-send-email-sbeller@google.com> <1425085318-30537-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 13:27:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRgUT-0004Np-Ho
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 13:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbbB1M0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 07:26:45 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:45321 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbbB1M0o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2015 07:26:44 -0500
Received: by igjz20 with SMTP id z20so6888828igj.4
        for <git@vger.kernel.org>; Sat, 28 Feb 2015 04:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ObNP45rsYOema+tMuL2GU24yQu2/IWiHJhX0WrQeSJ8=;
        b=KOCPrr205OCBEBOE/0W3AJZ170lfd+UVOmv1VpEMr/87IQYKzov9DUaGZGstr0qa4q
         I+i0GX5DcxMM5uS+VsGvhE4DctGyqHntrAkqfyi2gC5zqB929syTmOiS17RV8rYQGIcD
         LE4Fp1S45sDZdWrFlPZ6PglF4pBzKnEKgJrD2O+3++7Q+6OvKFb7VTiKwmV47PFGxL5f
         dY0IyUJvDdAj5fBXZlA+2FK19y2G4ysiIs0K92FNRiXlfdCE8RoQ6Gbbui5OCH64BD1P
         iBCXBplO+d1OcZluVTyzZ5ryumNA67B9dJaxFxmF4nwTUWQeeIdHvXa4gHPd/BJWEkM3
         Ku8A==
X-Received: by 10.50.118.97 with SMTP id kl1mr10398321igb.23.1425126404096;
 Sat, 28 Feb 2015 04:26:44 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Sat, 28 Feb 2015 04:26:13 -0800 (PST)
In-Reply-To: <1425085318-30537-6-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264529>

On Sat, Feb 28, 2015 at 8:01 AM, Stefan Beller <sbeller@google.com> wrote:
> diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
> index 4f8a7bf..40ddb37 100644
> --- a/Documentation/technical/protocol-capabilities.txt
> +++ b/Documentation/technical/protocol-capabilities.txt
> @@ -3,6 +3,10 @@ Git Protocol Capabilities
>
>  Servers SHOULD support all capabilities defined in this document.
>
> +The client MAY ask for capabilities first out of band to the server.
> +If so the server MUST NOT advertise any capabilities the client did
> +not ask for.

I think what the current patches do is "For v2, the client must _tell_
the server its capabilities". The unwritten statement is "the server
must not use any capabilities not advertised by the client". v2 will
not send initial refs by default, and the client will need to send
"wantrefs refs/heads/* refs/tags/*" or similar to retrieve ref list.
So we don't have any client capability yet. But there are two caps
that come to mind:

 - ref list compression (for sending full ref list in clone),
compression ratio may be 50%
 - setting locale in upload-pack and receive-pack to support l10n.

>  On the very first line of the initial server response of either
>  receive-pack and upload-pack the first reference is followed by
>  a NUL byte and then a list of space delimited server capabilities.

This one should be prefixed with "in version 1, "
-- 
Duy
