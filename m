From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v2] builtin/commit.c: memoize git-path for COMMIT_EDITMSG
Date: Thu, 9 Jun 2016 15:24:54 +0530
Message-ID: <CAFZEwPPRirGKqA4=qY+TrSmkGomZVZjLqOG-ZKwciK8hLhhdHg@mail.gmail.com>
References: <1464027390-1512-1-git-send-email-pranit.bauva@gmail.com>
 <20160524191950.21889-1-pranit.bauva@gmail.com> <CAFZEwPOZSU315oCJSdawtacPmgZobCnkkguTnSy1_V7x_n09kw@mail.gmail.com>
 <20160609065805.GA19015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 11:55:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAwg8-0007yu-94
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 11:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbcFIJy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 05:54:58 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34149 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbcFIJy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 05:54:56 -0400
Received: by mail-yw0-f196.google.com with SMTP id j74so4128018ywg.1
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 02:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ve/NjPmVhnqY88rU7yNTIXPTSSxKZ8TXtNbOJqzqm0E=;
        b=tBua1Hz9jB6CNoxjZt3xsQKesIGj/WLVkXmQYFTHmWM/73IJmCuijmN+ne6+Cfu1tk
         YxOnACiyf3e/9X7Je3MljI3JAtQhd+N3it9e/rfKffP0ir3fQcOd6b8dbZhfMeUPHoN/
         /1T6CBaFp6vV93kIs5rawMBzHuNcd+Stlt0ZKrQU9iPSqW63CJIdY8xk1R4SaKyPGTmK
         N/X4BzWKVVXv2oPhO45BExRZ8IY9c00RqX9ZkuZjxEF8VG9YjI4QA10KL+8Nlv3sdH8+
         58OsqFwpODARcnsdNnasV/0F1GyHbs6MnKHRgpGB+gzw/na59r+SwVQyAaSxURUm74KY
         m6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ve/NjPmVhnqY88rU7yNTIXPTSSxKZ8TXtNbOJqzqm0E=;
        b=E1O+hr3W9q3sGp0sPwf3odvULgCFBYEHiK2bdXkEr7Ut3ONCOqvAfvmGr+YGhtqEE4
         0PadhqXaJaG/ukUhAEci815xq36T4qJ6qjmSW0Aegi61V2xePT4GQHcs2yAMpX4q5A9i
         vwh9fEJkCVfVvQ/BErZBX+lKFMgABvDjJOP3GNiX347zIb5O5IAkZ32X1/dyLd3P8l19
         QZq17mRvfVWpK+7SgKct6XnrKRpKeGttj228U5LylRuwmN/ZQmeB7Y33Pu2Blesnaz80
         AfXaSnilYPn5j9L58gtTR/g1SuSeAIXNq67CsjwHtAXWWbXTGKM3iMEbpZn69Fcu9/5W
         C6Rw==
X-Gm-Message-State: ALyK8tLrHFgl3AIR4o8qgMolTHv8zVWlGO555BcBWzfBE5IYRwRujXMqhuvvYPMcymXPbwHFlNQgqY6lIpsy/Q==
X-Received: by 10.129.164.145 with SMTP id b139mr5780582ywh.171.1465466095265;
 Thu, 09 Jun 2016 02:54:55 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Thu, 9 Jun 2016 02:54:54 -0700 (PDT)
In-Reply-To: <20160609065805.GA19015@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296878>

Hey Jeff,

On Thu, Jun 9, 2016 at 12:28 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 07, 2016 at 08:25:17PM +0530, Pranit Bauva wrote:
>
>> On Wed, May 25, 2016 at 12:49 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> > This is a follow up commit for f932729c (memoize common git-path
>> > "constant" files, 10-Aug-2015).
>> >
>> > The many function calls to git_path() are replaced by
>> > git_path_commit_editmsg() and which thus eliminates the need to repeatedly
>> > compute the location of "COMMIT_EDITMSG".
>> >
>> > Mentored-by: Lars Schneider <larsxschneider@gmail.com>
>> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>> > Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> > ---
>> [...]
>> Anyone any comments?
>
> Looks good to me. You may want to re-post without the quoting to make it
> easier for the maintainer to pick up, and feel free to add my:
>
>   Reviewed-by: Jeff King <peff@peff.net>

Sure I could re-post it. Thanks for your tag! :)

Regards,
Pranit Bauva
