From: =?UTF-8?Q?Jens_Lindstr=C3=B6m?= <jl@opera.com>
Subject: Re: [PATCH] Clear fd after closing to avoid double-close error
Date: Wed, 23 Oct 2013 09:52:21 +0200
Message-ID: <CAEef6Wyui5EkNoEGKfb+NHZyb3BTkHME234M1zMyjuux5yMUeg@mail.gmail.com>
References: <1382443823-31317-1-git-send-email-jl@opera.com>
	<CACsJy8DtvaojrrQr4=uYCRse7N+SXb+WdjY+C_0FRSjYsNC6zg@mail.gmail.com>
	<xmqq8uxltaeh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 09:52:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYtEx-0001SV-EL
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 09:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275Ab3JWHwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 03:52:23 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:45014 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238Ab3JWHwW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 03:52:22 -0400
Received: by mail-lb0-f175.google.com with SMTP id z5so419962lbh.34
        for <git@vger.kernel.org>; Wed, 23 Oct 2013 00:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VwGt6VeKyBpC51C36af0yLSotmtlpMOZxkMSDIPfTPA=;
        b=kgESv+4B6ZSY1tOMtfSbabV3NZxACDAOSdLDiVWpowa07RFK+ac/1+4whJV19PpqDO
         XCsiYjUoEBwWaD1b3uuFZ8FVIZrQ9PBpwIIsMxbiLMS7bG1c5WcC74fvg6NH6RYYzLDs
         2KCHiXat5HrOgMBSfGe9Qjgq54rXK/Rg49GpdpkHuAKcHOE7V1TCQhSmIL5dw06OU3w/
         zgAXZVjvw4ys4bCXcZWvCUD+M7mFqvYio2iG3YqSS3y/X5GkxsbBSea6cM5KWNW8PtMK
         URELaMxaZvjQ8VuittwW+QTSyUIaGavCjI9Tjpj8ISXRqynYt2H/XXn99EFm7NJIUqBJ
         0WMA==
X-Gm-Message-State: ALoCoQlxmOIddMaJq5v6iPXSx2PWFe4pbI5N/wKUL2sOmKU/ucY6tAC4+edFJqb3uLjZZeMerG61
X-Received: by 10.152.116.7 with SMTP id js7mr160300lab.11.1382514741341; Wed,
 23 Oct 2013 00:52:21 -0700 (PDT)
Received: by 10.112.56.171 with HTTP; Wed, 23 Oct 2013 00:52:21 -0700 (PDT)
In-Reply-To: <xmqq8uxltaeh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236500>

On Tue, Oct 22, 2013 at 8:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:

>> Life would have been simpler if fd[1] was _always_ closed by
>> send_pack(), like in c20181e (start_command(), if .in/.out > 0, closes
>> file descriptors, not the callers - 2008-02-21).
>
> Yeah, that was also my first reaction when I saw the above three
> lines after reading the discussion that led to the diagnosis.

If send_pack() always closes fd[1], then I believe "git send-pack
--stateless-rpc --helper-status" would die in print_helper_status(),
called after send_pack(), since fd[1] would be 1, to which
print_helper_status() will try to write. (I don't know what either
--stateless-rpc or --helper-status mean, other than what's obvious
from the code, or if the combination of them makes any sense.)

I don't really have any more time to spend on this issue, so if a more
thorough fix is required, I'm afraid someone else will have to work on
it.

/ Jens
