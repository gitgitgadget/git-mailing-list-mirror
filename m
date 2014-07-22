From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 05/12] refs.c: pass NULL as *flags to read_ref_full
Date: Tue, 22 Jul 2014 11:19:52 -0700
Message-ID: <CAL=YDWnoCqEAN8+XPiVgPqUazAbzKG2oedLGBtEwPGCJMm_ctg@mail.gmail.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
	<1405549392-27306-6-git-send-email-sahlberg@google.com>
	<xmqqd2d2l2o7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 20:19:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9efO-0008A4-3V
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 20:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216AbaGVSTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 14:19:54 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:40051 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213AbaGVSTx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 14:19:53 -0400
Received: by mail-vc0-f171.google.com with SMTP id hq11so69913vcb.30
        for <git@vger.kernel.org>; Tue, 22 Jul 2014 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rTaojRlqmCfbNmQRyAQKJlr2C4FU9Cz6lzcojRqping=;
        b=mkbeKLXOh+ne86hMNEnna1tcGYKFW41OXHz0Hr3LJtzJRQT5q7eP+ZvtfCo1yFV0ft
         /dAJR+DcyKlSfH5e30KX91MDhw4mjhxPRSpXOkEXoZj+VXrtFmFemW/QgFVrb0TtJpxg
         U1khao5aPIePI6hBhR4+xXHj4mXicMGO/uDx+B5dUAVBiq/tS/ObB8EezFe7vLHjCI+I
         7aa/dMKwIeFpPH5zoPz3bbb+3nX30+2/OazuWEw2+K3cYr369FtGoL6iaD56z0uQ9GKY
         7TR2j2pJNOyJ7Apd6yT88gJTG8freNIWqL1Y1BvxuxEviOrvC+XR20MrFWaRFtpBvAxz
         tu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rTaojRlqmCfbNmQRyAQKJlr2C4FU9Cz6lzcojRqping=;
        b=SOUesUCLMobQ31bmRntgQtrsjglBrIY926BOphe66/O4QITxHiEPGBDWDzOewqFr/m
         RkYWN3aL10gJZEqr0rHSGCBZLz3fNfnjhYhXwXw5AtS2LXz+8CCSmwGRpuP1Xia9cYT0
         MgB6s4RNlL1KI59aWaMEnRWv7aTeoevpHO81gDoGSVFKf41Gc8tyMJIlJH/uX0P2YKe+
         VkgHPnj21xBuO3LjfKEw4WDUwYWd0BG+iQ+lyHOxZ5QnshkzpnyliqMiV/XHp5r+Xiwb
         wxPOGGLG1BRfAMqCWoG125c7IDcxVKc8yLkQw6YsUvWE8OCE5QfUKyT8EdDk5ak89gf7
         TO+Q==
X-Gm-Message-State: ALoCoQkyK5KJQYMhFxqRugKvkK90n9SSkuaxsyCMPu6Q+R4aUTmdG5XYR5VtGv/Y47wemncqNfJ3
X-Received: by 10.53.1.231 with SMTP id bj7mr35991100vdd.49.1406053192421;
 Tue, 22 Jul 2014 11:19:52 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Tue, 22 Jul 2014 11:19:52 -0700 (PDT)
In-Reply-To: <xmqqd2d2l2o7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254027>

On Fri, Jul 18, 2014 at 3:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> We call read_ref_full with a pointer to flags from rename_ref but since
>> we never actually use the returned flags we can just pass NULL here instead.
>
> Sensible, at least for the current callers.  I had to wonder if
> rename_ref() would never want to take advantage of the flags return
> parameter in the future, though.  For example, would it want to act
> differently when the given ref turns out to be a symref?

I don't know.

We have a check if the old refname was a symref or not since the old
version did not have code for how to handle renaming the reflog.
(That check is removed in a later series when we have enough
transaction code and reflog api changes so that we no longer need to
call rename() for the reflog handling.)

I can not think of any reason right now why, but if we need it we can
add the argument back when the need arises.

> Would it
> want to report something when the ref to be overwritten was a broken
> one?

Good point.

There are two cases where the new ref could be broken.
1) It could either contain a broken SHA1, like if we do this :
$ echo "Broken ref" > .git/refs/heads/foo-broken-1
2) or it could be broken due to having a bad/invalid name :
$ cp .git.refs.heads.master .git/refs/heads/foo-broken-1-\*...

For 2) I think this should not be allowed so the rename should just
fail with something like :
$ ./git branch -M foo foo-broken-1-\*...
fatal: 'foo-broken-1-*...' is not a valid branch name.

For 1)  if the new branch already exists but it has a broken SHA1, for
that case I think we should allow rename_ref to overwrite the existing
bad SHA1 with the new, good, SHA1 value.
Currently this does not work in master :
$ echo "Broken ref" > .git/refs/heads/foo-broken-1
$ ./git branch -m foo foo-broken-1
error: unable to resolve reference refs/heads/foo-broken-1: Invalid argument
error: unable to lock refs/heads/foo-broken-1 for update
fatal: Branch rename failed


And the only way to recover is to first delete the branch as my other
patch in this series now allows and then trying the rename again.

For 1), since we are planning to overwrite the current branch with a
new SHA1 value, I think that what makes most sense would be to treat
the "branch exist but is broken" as if the branch did not exist at all
and just allow overwriting it with the new good value.



Currently this does not work in master :

$ echo "Broken ref" > .git/refs/heads/foo-broken-1
$ ./git branch -m foo foo-broken-1
error: unable to resolve reference refs/heads/foo-broken-1: Invalid argument
error: unable to lock refs/heads/foo-broken-1 for update
fatal: Branch rename failed
so since this is not a regression I will not update this particular
patch series but instead I
can add a new patch to the next patch series to allow this so that we can do :
$ echo "Broken ref" > .git/refs/heads/foo-broken-1
$ ./git branch -m foo foo-broken-1
<success>


Comments/opinions?

regards
ronnie sahlberg


>
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  refs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 7d65253..0df6894 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2666,7 +2666,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>>               goto rollback;
>>       }
>>
>> -     if (!read_ref_full(newrefname, sha1, 1, &flag) &&
>> +     if (!read_ref_full(newrefname, sha1, 1, NULL) &&
>>           delete_ref(newrefname, sha1, REF_NODEREF)) {
>>               if (errno==EISDIR) {
>>                       if (remove_empty_directories(git_path("%s", newrefname))) {
