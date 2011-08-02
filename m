From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: filenames in repo are in CP1251; I have linux and UTF-8
Date: Tue, 2 Aug 2011 17:02:01 +0400
Message-ID: <CAHkcoti0G9gfHG3oiTXT0Cd3t8nnb_be90Zw-YPrjPECsR+jqQ@mail.gmail.com>
References: <1167098359.20110802115414@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 15:02:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoEbp-0004KH-Tt
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 15:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489Ab1HBNCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 09:02:05 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33127 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433Ab1HBNCD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 09:02:03 -0400
Received: by qwk3 with SMTP id 3so3301589qwk.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 06:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PSSX5Mo3wQshKnLmVtgW0XZySXLMby0hCLk14sRf5Qc=;
        b=iKSOdsBZp1XwhrQPAnXbNgMt6v5KZHNvejdV+QkZQYfNWyYofkNmWHOAnlB4IFsKxf
         igxOFgGJd4c8l9Ei8LotpB2Pry8Lt1gU5VuoBLvyrHPu2DvAMyKVgqjSK7r05aVyBt44
         CyY2m2hwdHX//DsdITgV4dU6x6RGIL6Jz1ANU=
Received: by 10.229.17.196 with SMTP id t4mr3893289qca.276.1312290121783; Tue,
 02 Aug 2011 06:02:01 -0700 (PDT)
Received: by 10.229.88.136 with HTTP; Tue, 2 Aug 2011 06:02:01 -0700 (PDT)
In-Reply-To: <1167098359.20110802115414@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178466>

Hi!

On Tue, Aug 2, 2011 at 11:54 AM, Ilya Basin <basinilya@gmail.com> wrote:
>
> Unlike on Cygwin, LANG has no effect for git filenames on Linux. Good
> thing, there's no conversion to unicode, so files aren't lost at
> checkout.

LANG has no effect on open() or other system functions on Linux, so
all filenames are created as they were stored in Git, in your case,
it is CP1251.

AFAIK, it should not be difficult to configure CP1251 on Linux. You
generate the required locale and then start xterm with this locale
and specifying some CP1251 font.

I have never done it before, but the following steps seem to work:

# generate CP1251
sudo localedef -c -i ru_RU -f CP1251 ru_RU.CP1251

# make sure that it was generated
# you should see ru_RU.cp1251 in the output
locale -a | grep ru_RU

# start xterm
LANG=ru_RU.cp1251 xterm -fn '-monotype-courier
new-semilight-r-normal--0-0-0-0-c-0-microsoft-cp1251' &

You can try another font. See the output of xlsfonts:
  xlsfonts | grep -i cp1251

>
> Question: is there a way to tell git on Linux to use UTF-8 filenames
> for the working tree, while storing them in CP1251?

The short answer is no. A more detail answer is that there was
a series of patches that should allow filename conversation:

http://article.gmane.org/gmane.comp.version-control.git/119224

but a proper implementation turned out to be very invasive and
no one seems to care about it very deeply, so it was dropped.
See details here:

http://article.gmane.org/gmane.comp.version-control.git/122860


Dmitry
