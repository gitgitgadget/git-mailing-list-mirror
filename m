From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 1/5] refs.c: allow passing raw git_committer_info as email
 to _update_reflog
Date: Mon, 28 Jul 2014 11:01:17 -0700
Message-ID: <CAL=YDWmSKBnjXiBUJjOb-+M7R8d==mMsN11DjDTDxU2+WAh+vQ@mail.gmail.com>
References: <1406307521-10339-1-git-send-email-sahlberg@google.com>
	<1406307521-10339-2-git-send-email-sahlberg@google.com>
	<20140725193728.GG12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:01:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBpEh-0000fE-Fv
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 20:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbaG1SBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 14:01:19 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:64663 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbaG1SBS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 14:01:18 -0400
Received: by mail-vc0-f180.google.com with SMTP id ij19so11750838vcb.11
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PG7SPQig6e7kDAG/5nCyh4b/CxIZ5/WAh95udt/W5qs=;
        b=PdAlIw1Sekwk8cIi1qZ2dD+4M0GF1gpTUUmLHBdKIGjU6WqXD6TQUMvVjRxfR36JQk
         t+w6j0cQSwdNKq5GqHSq5yOGGbEwdmc9vZTDlbGTcFk7AFp1xLbOxQgpZqLFPIPzMT9S
         SS588r9ULP92bftmUHUBypqe5uyuCuDuOGtOYUJ+u5o8oHwxhLK8nujeGvUapFpVB9uA
         HuhVe2aaiLZPKP8CPAM5cpXHkLwke/2auxIXhis0ACB3qQ38G3Ou2Nr19gyZkbo+3LrB
         fUZnwoDv8+Yr+OynVCRnVgBjpF2W7Yi1oXv2uf+KygVqHmIaHsjV2cNEogQYY5X2QAnO
         1Tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=PG7SPQig6e7kDAG/5nCyh4b/CxIZ5/WAh95udt/W5qs=;
        b=Zf/wdAKO7Xpyfah7G8dG/u8lmPloJfTUkRsMdyQO7ktllLPUH6bL8OfiSlG7aYFa/M
         JsUHklF441C9DyaLr0zj1l1xo87pHT2vzxCS2juJC0jsG2MtBaif0FcQIZ6F2Skkwcci
         xBorWvJsV8gb+2Lbyk+3V445g6/+NHrUiuCFJiYIqLwwJ2GPR1cMDLuiXZDECClW0FHH
         1UYrK2D1ffnKlvWlpowPJ30q5yhCfSpbvmdh5Fcy5BADUAnNRouK9o6zX5Jj5Ft4wcav
         bgdwkNuC90PoqntI9B1nBZ4Is3hLX0qxcJ4Wt5R2nltFl+0681Q48oQkIaiwLdFsmnq3
         zD9g==
X-Gm-Message-State: ALoCoQnJQxWK8rh9/GyVvrAKZWi8E7sIg/gpS68Qzs1fOrey6+D+ujPx/z4AF7nUKZ35hM9XCyH8
X-Received: by 10.53.12.225 with SMTP id et1mr19851045vdd.5.1406570477961;
 Mon, 28 Jul 2014 11:01:17 -0700 (PDT)
Received: by 10.52.180.6 with HTTP; Mon, 28 Jul 2014 11:01:17 -0700 (PDT)
In-Reply-To: <20140725193728.GG12427@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254330>

On Fri, Jul 25, 2014 at 12:37 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Add a new flag REFLOG_EMAIL_IS_COMMITTER to _update_reflog to tell it
>> that what we pass in as email is already the fully baked committer string
>> we can use as-is.
>
> With and without the new flag, the 'email' argument has two different
> meanings:
>
>  * with the new flag, it should be an ident string, like
>    'Jonathan Nieder <jrnieder@gmail.com> 1406251347 -0700'
>
>  * without it, it should be the name-part of an ident string,
>    like 'Jonathan Nieder <jrnieder@gmail.com>
>
> In neither case is it an email address.  This seems unnecessarily
> confusing.

True.

I have changed it to to be a field named 'id' instead of 'email'.
I also added changes to update other places in the code to change the
name for this to 'id' too.

It is confusing. I too were caught by this a while back when just
based on the name for the callback iterators
I assumed what was passed there was an email address while it was not.
I didn't fix that then but I fixed it now.


Thanks!


>
> Is the caller responsible for checking the argument for validity?
> Do callers do so?  Is this performance-critical or could the
> transaction_update_reflog function do a sanity-check?

I have added basic sanity checks, such as required strings are non-NULL.

>
> [...]
>>  /*
>>   * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
>>   * this update will first truncate the reflog before writing the entry.
>>   * If msg is NULL no update will be written to the log.
>>   */
>>  int transaction_update_reflog(struct ref_transaction *transaction,
>>                                const char *refname,
>>                                const unsigned char *new_sha1,
>>                                const unsigned char *old_sha1,
>>                                const char *email,
>>                                unsigned long timestamp, int tz,
>>                                const char *msg, int flags,
>>                                struct strbuf *err);
>
> This is a lot of parameters, some optional, not all documented.  Would
> it make sense to pack some into a struct?

I changed email,timestamp,tz into a struct
/*
 * Committer data provided to reflog updates.
 * If flags contain REFLOG_COMMITTER_DATA_IS_VALID then
 * then the structure contains a prebaked committer string
 * just like git_committer_info() would return.
 *
 * If flags does not contain REFLOG_COMMITTER_DATA_IS_VALID
 * then the committer info string will be generated using the passed
 * email, timestamp and tz fields.
 * This is useful for example from reflog iterators where you are passed
 * these fields individually and not as a prebaked git_committer_info()
 * string.
 */
struct reflog_committer_info {
const char *committer_info;

const char *id;
unsigned long timestamp;
int tz;
};

>
> Thanks and hope that helps,
> Jonathan
