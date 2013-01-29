From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] status: show branch name if possible in in-progress info
Date: Tue, 29 Jan 2013 19:56:21 +0700
Message-ID: <CACsJy8DLdG9O+HaWS8u4n+imdaSZe=GrbYbPOhcMsYMWDq9NZw@mail.gmail.com>
References: <1359461450-24456-1-git-send-email-pclouds@gmail.com> <vpqy5fcrwzq.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jan 29 13:57:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0AkU-0000ko-JB
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 13:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab3A2M4x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2013 07:56:53 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:44582 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab3A2M4w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jan 2013 07:56:52 -0500
Received: by mail-ob0-f177.google.com with SMTP id wc18so359672obb.8
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 04:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=sAMaNGq9NuiwOwFUbrh1j9amcF6pkcA2qo4+xXrmjy0=;
        b=UJc/f+1+lHv8W+uGj4krLsq42jtt71t4ZPQfHaO+UIvAOJJJ+TZGJZv8eOmuL7P6XE
         tGwtvXwKHSvP/+iZUYWh1h7asj1jatiqZEvdcNdgjeSulJ9NSqpaP6u5RDW4FO4XqGIy
         i+SPaP2YuFdWH17boCCU3FUCtACUcEE1g+Pe3dPJ5V67LFAL4NwHDWxsamnPbDGlqIqg
         jfzNkqyXDJXfEmrnsetpKzjNavQrRDD4fQECJ/SbnCpZyfw4tDNaRX8DGso9AKkPpUk8
         qYAolWKmKoj1jwGj+v5FIuiMYvJS/+zefRTtFBQqQNszVJzGn2+NFCD2FTn1cfecHyuN
         z0uQ==
X-Received: by 10.182.12.4 with SMTP id u4mr602125obb.74.1359464211895; Tue,
 29 Jan 2013 04:56:51 -0800 (PST)
Received: by 10.182.118.229 with HTTP; Tue, 29 Jan 2013 04:56:21 -0800 (PST)
In-Reply-To: <vpqy5fcrwzq.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214936>

On Tue, Jan 29, 2013 at 7:31 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> I like the idea.
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
>> index b3f6eb9..096ba6f 100755
>> --- a/t/t7512-status-help.sh
>> +++ b/t/t7512-status-help.sh
>> @@ -76,7 +76,7 @@ test_expect_success 'status when rebase in progres=
s before resolving conflicts'
>>       test_must_fail git rebase HEAD^ --onto HEAD^^ &&
>>       cat >expected <<-\EOF &&
>>       # Not currently on any branch.
>> -     # You are currently rebasing.
>> +     # You are currently rebasing '\''rebase_conflicts'\''.
>
> Perhaps "rebasing *branch* 'rebase_conflicts'"

Looks good. One minor thing, if the ref happens to be
refs/somewhere-not-in-heads, should we still say "rebasing branch
'refs/...'" or just "rebasing 'refs/...'", or something else?

>
> Or even "rebasing branch 'rebase_conflicts' on <sha1sum>"

<sha1sum> being SHA-1 of HEAD? Why would you need it? In short
version, not full SHA-1?

> ?
>
>> @@ -923,7 +947,7 @@ static void show_bisect_in_progress(struct wt_st=
atus *s,
>>                               struct wt_status_state *state,
>>                               const char *color)
>>  {
>> -     status_printf_ln(s, color, _("You are currently bisecting."));
>> +     status_printf_ln(s, color, _("You are currently bisecting '%s'=
=2E"), state->branch);
>>       if (advice_status_hints)
>>               status_printf_ln(s, color,
>>                       _("  (use \"git bisect reset\" to get back to =
the original branch)"));
>
> In the "rebase" case, you test state->branch for null-ness. Don't you
> need the same test here? (What happens if you start a bisect from a
> detached HEAD state?)

I did read git-bisect.sh. I did not think it allowed bisecting on
detached HEAD. A simple test just told me otherwise. Will update.
--=20
Duy
