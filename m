From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 27/48] sequencer.c: use ref transactions for all ref updates
Date: Mon, 14 Jul 2014 15:20:51 -0700
Message-ID: <CAL=YDWkaW_di822qYsf5iKHqfriTjJm6exMVTpbvBunijqgUmQ@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-28-git-send-email-sahlberg@google.com>
	<53BBE2D6.2070809@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 15 00:21:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6ocD-0000Ys-2N
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 00:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbaGNWUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 18:20:53 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:44560 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932391AbaGNWUw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 18:20:52 -0400
Received: by mail-vc0-f178.google.com with SMTP id la4so1874267vcb.9
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 15:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+Xz8fZ/js/xLOECqq32Goo1ZZO4ejSFe4WyA448l1TY=;
        b=Wqhv715jWQtKx+Ppy2/xmkio3joy76H+KeoaRlDZItRWErIkgdPlnQLEGdCoaLZADU
         AW0r3NEu4r8pU9q5oxN7WQkrdu0L54WB/wbg1mrdQhycOh7E4UKv9ZaT6Eja5Xj1C74R
         bagsQ8jkp2Aaqz7G/VV/298hTzJahVFKSUPfGNq8PXaH2pBgppvuDpAOpeGRIcXhV9S+
         lqxX1r0E4kBgjF4TvFH0HV37Zejrz6m+8xNjPjr+NqJJ8u/bmxZzjoYIM+BOx8tfqdwY
         95GLvbMXW80IR4oy+MaA9vfSjzhpjW3ye1cBtLxhE4SHfKJXabyT38VHAZziO3RoiU1A
         AORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+Xz8fZ/js/xLOECqq32Goo1ZZO4ejSFe4WyA448l1TY=;
        b=QZRC1MfYxkDnKNFPZEqZsji90JzzjodnlcAKldxr9jO7NoA2WdZG3ndYlybD6OdPBx
         uqluJ2/Zaga9O1x5G7kSYK955f+XUw4VInmVE6fXQVbMsrmuLkgMcZb0qgBUSyMQzfyI
         nyHiXT8hLmrM9FwqTOA+6vjnwlH+dLC9O5iJT95QkQdeAFjaO4jeVE5KYIq9pvewESh8
         SK6nj3hkPsJbzxXwZByJDfHEDgrM/TSx85SeAnnITmqTiye3a9zkPkmczxgjGbPqsnWh
         00EFsE0dpY1XPuAqQ1ctrx+Eyc2q5cXW5C5hflKFftihtf3syB3nhQrwv6hnZpKCYCNj
         uwLw==
X-Gm-Message-State: ALoCoQmQu1lu7C2tjUBLrzM0hqtpAfZrCKiRFvribQ0L2A5g9yyNLTBVZDINReRbE34WV70B+q+T
X-Received: by 10.221.9.72 with SMTP id ov8mr5152565vcb.27.1405376451509; Mon,
 14 Jul 2014 15:20:51 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Mon, 14 Jul 2014 15:20:51 -0700 (PDT)
In-Reply-To: <53BBE2D6.2070809@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253543>

On Tue, Jul 8, 2014 at 5:23 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
>> Change to use ref transactions for all updates to refs.
>>
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  sequencer.c | 24 ++++++++++++++++--------
>>  1 file changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 0a80c58..fd8acaf 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -272,23 +272,31 @@ static int error_dirty_index(struct replay_opts *opts)
>>  static int fast_forward_to(const unsigned char *to, const unsigned char *from,
>>                       int unborn, struct replay_opts *opts)
>>  {
>> -     struct ref_lock *ref_lock;
>> +     struct ref_transaction *transaction;
>>       struct strbuf sb = STRBUF_INIT;
>> -     int ret;
>> +     struct strbuf err = STRBUF_INIT;
>>
>>       read_cache();
>>       if (checkout_fast_forward(from, to, 1))
>>               exit(1); /* the callee should have complained already */
>> -     ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
>> -                                        0, NULL);
>> -     if (!ref_lock)
>> -             return error(_("Failed to lock HEAD during fast_forward_to"));
>
> I think you've changed the semantics when unborn is set.  Please note
> that lock_any_ref_for_update() behaves differently if old_sha1 is NULL
> (when no check is done) vs. when it is null_sha1 (when it verifies that
> the reference didn't previously exist).  So when unborn is true, the old
> code verifies that the reference previously didn't exist...
>
>>
>>       strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
>> -     ret = write_ref_sha1(ref_lock, to, sb.buf);
>> +
>> +     transaction = ref_transaction_begin(&err);
>> +     if (!transaction ||
>> +         ref_transaction_update(transaction, "HEAD", to, from,
>> +                                0, !unborn, &err) ||
>
> ...whereas when unborn is true, the new code does no check at all.  I
> think you want
>
>     ref_transaction_update(transaction, "HEAD",
>                            to, unborn ? null_sha1 : from,
>                            0, 1, &err) ||
>

Right.  Fixed.

Thanks.
