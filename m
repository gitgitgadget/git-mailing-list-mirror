From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT v4 15/33] Produce legal patch names in guilt-import-commit.
Date: Thu, 22 Jan 2015 16:50:51 +0100
Message-ID: <CAP=KgsTjLT5xqy0G1vc9RFa85gpAxtOfGcT+KuqVro7QHXaLrw@mail.gmail.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
	<1400450409-30998-16-git-send-email-cederp@opera.com>
	<20150122141545.GB101460@meili.jeffnet.31bits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Thu Jan 22 16:51:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEK26-0002CD-4N
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 16:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbbAVPuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 10:50:54 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:53946 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbbAVPuw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 10:50:52 -0500
Received: by mail-ie0-f182.google.com with SMTP id ar1so2022646iec.13
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 07:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=OalYnc1XpEI9hXdMWJqTTpYP4uFBq3GQXjRXs6XiNMg=;
        b=PmS6yXgv/zz1TbKgmS4ArzuLxzh20VQB0wJhZamPJTW8NQLQqp4mScR5B07xVfInbz
         ykgoS6GtC1WhN8aVvLLBPStpLbLIwn/zmwazEPrSJpfoh+uMAhIUXles/smIsuNocbz/
         J6MaNXkdlwlGOlAgH0BodXAbRAg5A17RUXwWJx2DdojZK3srMqvucf0Ny+nt88ZVPp2j
         9BcV0PGyXHMsmHs58DaTEYjFqurWQu7E5kDCbQ4SKSCHDOZrM29vLmM4EwFY/rcd+d1I
         vcoojll2nd/trNrcdau9NbAQrs3S+vLSWB1s3VCDelKFxjTGSFJ/aAw+ZjBchu8xn+Ky
         VSmw==
X-Gm-Message-State: ALoCoQmgrUvTJuliTdkMfoGd4mfkgOEk1WjauO/prtZc4Ub0RFVYBtAQkV1NnzJJHtYhyjzZF8DH
X-Received: by 10.50.254.99 with SMTP id ah3mr13270094igd.12.1421941851209;
 Thu, 22 Jan 2015 07:50:51 -0800 (PST)
Received: by 10.42.235.141 with HTTP; Thu, 22 Jan 2015 07:50:51 -0800 (PST)
In-Reply-To: <20150122141545.GB101460@meili.jeffnet.31bits.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262842>

Replacing echo with printf as in your patch works fine for me.

I've applied Signed-off-by lines from you for the latest commits,
rebased it on top of your current master commit, and pushed
the series to the oslo-2014-v5 branch of git://repo.or.cz/guilt/ceder.git

    /ceder

On Thu, Jan 22, 2015 at 3:15 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> I just tried to run the regression suite on my OpenIndiana laptop and I got
> this failure.
>
> 034: --- t-034.out      2015-01-22 14:02:23.634515474 +0000
> +++ /tmp/guilt.log.14878        2015-01-22 14:03:54.258790788 +0000
> @@ -83,7 +83,7 @@
>  [master aedb74f] @
>   Author: Author Name <author@email>
>   1 file changed, 1 insertion(+)
> -% create_commit a Backslash\is\forbidden.
> +% create_commit a Backslash\is
>                                orbidden.
>  [master 0a46f8f] Backslash\is\forbidden.
>   Author: Author Name <author@email>
>   1 file changed, 1 insertion(+)
> Test failed!
>
> Test:           034
> Log file:       /tmp/guilt.log.14878
> Repo dir:       "/tmp/guilt reg.12106"
>
> make[1]: *** [all] Error 1
>
>
> It's obviously the "cmd" command printing that's busted.  The following change
> makes the test suite pass.  Does it work for you?  (If so, I'll commit it after
> pulling your whole series.)
>
> Thanks,
>
> Jeff.
>
>
> diff --git a/regression/scaffold b/regression/scaffold
> index 97cff4e..593e9da 100644
> --- a/regression/scaffold
> +++ b/regression/scaffold
> @@ -50,7 +50,7 @@ function filter_dd
>  # usage: cmd <cmd>..
>  function cmd
>  {
> -       echo "% $@"
> +       printf "%% %s\n" "$*"
>         if ! (
>                 exec 3>&1
>                 rv=`(("$@" 2>&1; echo $? >&4) | replace_path >&3 ) 4>&1`
>
> On Sun, May 18, 2014 at 11:59:51PM +0200, Per Cederqvist wrote:
>> Try harder to create patch names that adhere to the rules in
>> git-check-ref-format(1) when deriving a patch name from the commit
>> message.  Verify that the derived name using "git check-ref-format",
>> and as a final fallback simply use the patch name "x" (to ensure that
>> the code is future-proof in case new rules are added in the future).
>>
>> Always append a ".patch" suffix to the patch name.
>>
>> Added test cases.
>>
>> Signed-off-by: Per Cederqvist <cederp@opera.com>
>> Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
>> ---
>>  guilt-import-commit  |  20 +-
>>  regression/t-034.out | 567 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  regression/t-034.sh  |  71 +++++++
>>  3 files changed, 656 insertions(+), 2 deletions(-)
>>  create mode 100644 regression/t-034.out
>>  create mode 100755 regression/t-034.sh
>>
>> diff --git a/guilt-import-commit b/guilt-import-commit
>> index f14647c..6260c56 100755
>> --- a/guilt-import-commit
>> +++ b/guilt-import-commit
>> @@ -28,19 +28,35 @@ disp "Current head: `git rev-parse \`git_branch\``" >&2
>>  for rev in `git rev-list $rhash`; do
>>       s=`git log --pretty=oneline -1 $rev | cut -c 42-`
>>
>> +     # Try to convert the first line of the commit message to a
>> +     # valid patch name.
>>       fname=`echo $s | sed -e "s/&/and/g" -e "s/[ :]/_/g" -e "s,[/\\],-,g" \
>>                       -e "s/['\\[{}]//g" -e 's/]//g' -e 's/\*/-/g' \
>> -                     -e 's/\?/-/g' | tr A-Z a-z`
>> +                     -e 's/\?/-/g' -e 's/\.\.\.*/./g' -e 's/^\.//' \
>> +                     -e 's/\.patch$//' -e 's/\.$//' | tr A-Z a-z`
>> +
>> +     if ! valid_patchname "$fname"; then
>> +             # Try harder to make it a legal commit name by
>> +             # removing all but a few safe characters.
>> +             fname=`echo $fname|tr -d -c _a-zA-Z0-9---/\\n`
>> +     fi
>> +     if ! valid_patchname "$fname"; then
>> +             # If we failed to derive a legal patch name, use the
>> +             # name "x".  (If this happens, we likely have to
>> +             # append a suffix to make the name unique.)
>> +             fname=x
>> +     fi
>>
>>       disp "Converting `echo $rev | cut -c 1-8` as $fname"
>>
>>       mangle_prefix=1
>>       fname_base=$fname
>> -     while [ -f "$GUILT_DIR/$branch/$fname" ]; do
>> +     while [ -f "$GUILT_DIR/$branch/$fname.patch" ]; do
>>               fname="$fname_base-$mangle_prefix"
>>               mangle_prefix=`expr $mangle_prefix + 1`
>>               disp "Patch under that name exists...trying '$fname'"
>>       done
>> +     fname="$fname".patch
>>
>>       (
>>               do_make_header $rev
>> diff --git a/regression/t-034.out b/regression/t-034.out
>> new file mode 100644
>> index 0000000..7bc9459
>> --- /dev/null
>> +++ b/regression/t-034.out
>> @@ -0,0 +1,567 @@
>> +% setup_git_repo
>> +% git tag base
>> +% create_commit a The sequence /. is forbidden.
>> +[master eebb76e] The sequence /. is forbidden.
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> + create mode 100644 a
>> +% create_commit a The sequence .lock/ is forbidden.
>> +[master 45e81b5] The sequence .lock/ is forbidden.
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a A/component/may/not/end/in/foo.lock
>> +[master bbf3f59] A/component/may/not/end/in/foo.lock
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a Two consecutive dots (..) is forbidden.
>> +[master 1535e67] Two consecutive dots (..) is forbidden.
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a Check/multiple/../dots/...../foo..patch
>> +[master 48eb60c] Check/multiple/../dots/...../foo..patch
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a Space is forbidden.
>> +[master 10dea83] Space is forbidden.
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a Tilde~is~forbidden.
>> +[master 70a83b7] Tilde~is~forbidden.
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a Caret^is^forbidden.
>> +[master ee6ef2c] Caret^is^forbidden.
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a Colon:is:forbidden.
>> +[master c077fe2] Colon:is:forbidden.
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a Del is forbidden.
>> +[master 589ee30] Del is forbidden.
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% git branch some-branch
>> +% git tag some-tag
>> +% create_commit a Ctrl is forbidden.
>> +[master e63cdde] Ctrl is forbidden.
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a CR
>> is
>> also
>> forbidden.
>> +[master 21ad093] CR
>> is
>> also
>> forbidden.
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a Question-mark?is?forbidden.
>> +[master be2fa9b] Question-mark?is?forbidden.
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a Asterisk*is*forbidden.
>> +[master af7b50f] Asterisk*is*forbidden.
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a Open[bracket[is[forbidden.
>> +[master 689f618] Open[bracket[is[forbidden.
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a Multiple/slashes//are//forbidden.
>> +[master 6e7d52a] Multiple/slashes//are//forbidden.
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a Cannot/end/in/slash/
>> +[master 95bb6cd] Cannot/end/in/slash/
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a Cannot end in ..
>> +[master 106e8e5] Cannot end in ..
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a Cannot@{have@{the@{sequence@{at-brace.
>> +[master 30187ed] Cannot@{have@{the@{sequence@{at-brace.
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a @
>> +[master aedb74f] @
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a Backslash\is\forbidden.
>> +[master 0a46f8f] Backslash\is\forbidden.
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% create_commit a Can/have/embedded/single/slashes
>> +[master 2a8b188] Can/have/embedded/single/slashes
>> + Author: Author Name <author@email>
>> + 1 file changed, 1 insertion(+)
>> +% git log
>> +commit 2a8b1889aa5066193bac978e6bf5073ffcfa6541
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Can/have/embedded/single/slashes
>> +
>> +commit 0a46f8fa7c8c5a6f1039f842fe5cbd21d3a2a2a6
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Backslash\is\forbidden.
>> +
>> +commit aedb74fd8388282fd7af50cb191a7f62bfc45eb5
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    @
>> +
>> +commit 30187ed0f47d12df9cedcbb846647d0d52130c12
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Cannot@{have@{the@{sequence@{at-brace.
>> +
>> +commit 106e8e5a8cceec7297af97376ca5f93506643d0b
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Cannot end in ..
>> +
>> +commit 95bb6cd7edf7b1e634a1e7d02c8faa99e39cbbf2
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Cannot/end/in/slash/
>> +
>> +commit 6e7d52a7dacc684225c11b4edd2bac25fb52bd9b
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Multiple/slashes//are//forbidden.
>> +
>> +commit 689f618085195775d204898254154b8bb50897a5
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Open[bracket[is[forbidden.
>> +
>> +commit af7b50f93854bc5f46de5a389c1f3dea081eae2f
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Asterisk*is*forbidden.
>> +
>> +commit be2fa9b5c5788dc05c4036f1b8197a1d33169610
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Question-mark?is?forbidden.
>> +
>> +commit 21ad093a0c1b4a96285180a3d7b99a4045ef9202
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    CR
>> is
>> also
>> forbidden.
>> +
>> +commit e63cdde7a1c90b66d7d411683528200f3f067d5f
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Ctrl is forbidden.
>> +
>> +commit 589ee305a82aacf155529e75cbc84e661c37c83d
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Del is forbidden.
>> +
>> +commit c077fe203fd18036fb00b56eec1763673d1769c6
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Colon:is:forbidden.
>> +
>> +commit ee6ef2cc9dd5525409300377b013c0d9734bd931
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Caret^is^forbidden.
>> +
>> +commit 70a83b705a2602a9493aba7f8f22e7abd13adc63
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Tilde~is~forbidden.
>> +
>> +commit 10dea8380135f4d10cd10324e13da659261ceda3
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Space is forbidden.
>> +
>> +commit 48eb60cddaefdaac5f78655f9028a9da741a18d1
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Check/multiple/../dots/...../foo..patch
>> +
>> +commit 1535e67718949abf72f843685a1672ebfe4bd21f
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Two consecutive dots (..) is forbidden.
>> +
>> +commit bbf3f5926e11d97b08cdb6e833c9deb603453d1b
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    A/component/may/not/end/in/foo.lock
>> +
>> +commit 45e81b5163ec3ed656b058ac3fd95b8986824e0f
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    The sequence .lock/ is forbidden.
>> +
>> +commit eebb76e96913d2dc78aef5f233fadc74af770b3b
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    The sequence /. is forbidden.
>> +
>> +commit d4850419ccc1146c7169f500725ce504b9774ed0
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    initial
>> +
>> +    Signed-off-by: Commiter Name <commiter@email>
>> +% guilt init
>> +% guilt import-commit base..HEAD
>> +About to begin conversion...
>> +Current head: 2a8b1889aa5066193bac978e6bf5073ffcfa6541
>> +Converting 2a8b1889 as can-have-embedded-single-slashes
>> +Converting 0a46f8fa as backslash-isorbidden
>> +Converting aedb74fd as x
>> +Converting 30187ed0 as cannot@have@the@sequence@at-brace
>> +Converting 106e8e5a as cannot_end_in_
>> +Converting 95bb6cd7 as cannot-end-in-slash-
>> +Converting 6e7d52a7 as multiple-slashes--are--forbidden
>> +Converting 689f6180 as openbracketisforbidden
>> +Converting af7b50f9 as asterisk-is-forbidden
>> +Converting be2fa9b5 as question-mark-is-forbidden
>> +Converting 21ad093a as crisalsoforbidden
>> +Converting e63cdde7 as ctrlisforbidden
>> +Converting 589ee305 as delisforbidden
>> +Converting c077fe20 as colon_is_forbidden
>> +Converting ee6ef2cc as caretisforbidden
>> +Converting 70a83b70 as tildeisforbidden
>> +Converting 10dea838 as space_is_forbidden
>> +Converting 48eb60cd as check-multiple-.-dots-.-foo
>> +Converting 1535e677 as two_consecutive_dots_(.)_is_forbidden
>> +Converting bbf3f592 as a-component-may-not-end-in-foolock
>> +Converting 45e81b51 as the_sequence_.lock-_is_forbidden
>> +Converting eebb76e9 as the_sequence_-._is_forbidden
>> +Done.
>> +Current head: d4850419ccc1146c7169f500725ce504b9774ed0
>> +% guilt push -a
>> +Applying patch..the_sequence_-._is_forbidden.patch
>> +Patch applied.
>> +Applying patch..the_sequence_.lock-_is_forbidden.patch
>> +Patch applied.
>> +Applying patch..a-component-may-not-end-in-foolock.patch
>> +Patch applied.
>> +Applying patch..two_consecutive_dots_(.)_is_forbidden.patch
>> +Patch applied.
>> +Applying patch..check-multiple-.-dots-.-foo.patch
>> +Patch applied.
>> +Applying patch..space_is_forbidden.patch
>> +Patch applied.
>> +Applying patch..tildeisforbidden.patch
>> +Patch applied.
>> +Applying patch..caretisforbidden.patch
>> +Patch applied.
>> +Applying patch..colon_is_forbidden.patch
>> +Patch applied.
>> +Applying patch..delisforbidden.patch
>> +Patch applied.
>> +Applying patch..ctrlisforbidden.patch
>> +Patch applied.
>> +Applying patch..crisalsoforbidden.patch
>> +Patch applied.
>> +Applying patch..question-mark-is-forbidden.patch
>> +Patch applied.
>> +Applying patch..asterisk-is-forbidden.patch
>> +Patch applied.
>> +Applying patch..openbracketisforbidden.patch
>> +Patch applied.
>> +Applying patch..multiple-slashes--are--forbidden.patch
>> +Patch applied.
>> +Applying patch..cannot-end-in-slash-.patch
>> +Patch applied.
>> +Applying patch..cannot_end_in_.patch
>> +Patch applied.
>> +Applying patch..cannot@have@the@sequence@at-brace.patch
>> +Patch applied.
>> +Applying patch..x.patch
>> +Patch applied.
>> +Applying patch..backslash-isorbidden.patch
>> +Patch applied.
>> +Applying patch..can-have-embedded-single-slashes.patch
>> +Patch applied.
>> +% git log --decorate
>> +commit 434e07cacdd8e7eb4723e67cb2d100b3a4121a3a (HEAD, refs/patches/master/can-have-embedded-single-slashes.patch, guilt/master)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Can/have/embedded/single/slashes
>> +
>> +commit 7c3ffa4f940c862e9f11f5d4a5ae421f7a8d3141 (refs/patches/master/backslash-isorbidden.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Backslash\is\forbidden.
>> +
>> +commit ea46f435d4d8f3c5349dce1aabc1a39fbf7ef803 (refs/patches/master/x.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    @
>> +
>> +commit a275ed5d7f10ea88c986852ee95a7d5a61663b5f (refs/patches/master/cannot@have@the@sequence@at-brace.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Cannot@{have@{the@{sequence@{at-brace.
>> +
>> +commit f091fee39457e64ebd35410c1cf95e6613816a54 (refs/patches/master/cannot_end_in_.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Cannot end in ..
>> +
>> +commit 025672497aff5c910c8ff86aaedc662f14c2f4ad (refs/patches/master/cannot-end-in-slash-.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Cannot/end/in/slash/
>> +
>> +commit f13e243c7c56f39422567a431bccceec8b789596 (refs/patches/master/multiple-slashes--are--forbidden.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Multiple/slashes//are//forbidden.
>> +
>> +commit edef5e925083d445f71c170d3293fac9619bc7a2 (refs/patches/master/openbracketisforbidden.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Open[bracket[is[forbidden.
>> +
>> +commit 1626a11d979a1e9e775c766484172212277153df (refs/patches/master/asterisk-is-forbidden.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Asterisk*is*forbidden.
>> +
>> +commit 74df14ab3a0ec9a0382998fbf167ebb1b0a36c6a (refs/patches/master/question-mark-is-forbidden.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Question-mark?is?forbidden.
>> +
>> +commit ec46429125abdb0c5ac2b46cc399bdcd7cfc73fd (refs/patches/master/crisalsoforbidden.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    CR
>> is
>> also
>> forbidden.
>> +
>> +commit 01524f9921af2a041cc88c068f76baa39e436cb2 (refs/patches/master/ctrlisforbidden.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Ctrl is forbidden.
>> +
>> +commit 9fc9677b61880f9159838e89f714893e0a2fcafb (refs/patches/master/delisforbidden.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Del is forbidden.
>> +
>> +commit 10433fd7206b7f79aabb4da514710d93c8deed4a (refs/patches/master/colon_is_forbidden.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Colon:is:forbidden.
>> +
>> +commit fb1edb753c97ec865ceea316420b1df586caaa2b (refs/patches/master/caretisforbidden.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Caret^is^forbidden.
>> +
>> +commit 3a0d5ccef0359004fcaa9cee98fbd6a2c4432e74 (refs/patches/master/tildeisforbidden.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Tilde~is~forbidden.
>> +
>> +commit ea22c3b49c448dba8d7eaa6b805f9f1bc83fbedc (refs/patches/master/space_is_forbidden.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Space is forbidden.
>> +
>> +commit db6ea8252440b04811344336f510a5469b2ddab0 (refs/patches/master/check-multiple-.-dots-.-foo.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Check/multiple/../dots/...../foo..patch
>> +
>> +commit fe07105cd62660f4440ad24b9fc7dfdd9e71d764 (refs/patches/master/two_consecutive_dots_(.)_is_forbidden.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Two consecutive dots (..) is forbidden.
>> +
>> +commit 96a3e92c4df85f52362ce4f6d31983c462db9ae9 (refs/patches/master/a-component-may-not-end-in-foolock.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    A/component/may/not/end/in/foo.lock
>> +
>> +commit ee4f0f96dfc9c94f5410c1e6414f9004325a37fc (refs/patches/master/the_sequence_.lock-_is_forbidden.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    The sequence .lock/ is forbidden.
>> +
>> +commit fdcb23c3072209bea3d9e0a2594132b936c5347e (refs/patches/master/the_sequence_-._is_forbidden.patch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    The sequence /. is forbidden.
>> +
>> +commit d4850419ccc1146c7169f500725ce504b9774ed0 (tag: base, master)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    initial
>> +
>> +    Signed-off-by: Commiter Name <commiter@email>
>> +% git log --decorate some-branch
>> +commit 589ee305a82aacf155529e75cbc84e661c37c83d (tag: some-tag, some-branch)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Del is forbidden.
>> +
>> +commit c077fe203fd18036fb00b56eec1763673d1769c6
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Colon:is:forbidden.
>> +
>> +commit ee6ef2cc9dd5525409300377b013c0d9734bd931
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Caret^is^forbidden.
>> +
>> +commit 70a83b705a2602a9493aba7f8f22e7abd13adc63
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Tilde~is~forbidden.
>> +
>> +commit 10dea8380135f4d10cd10324e13da659261ceda3
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Space is forbidden.
>> +
>> +commit 48eb60cddaefdaac5f78655f9028a9da741a18d1
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Check/multiple/../dots/...../foo..patch
>> +
>> +commit 1535e67718949abf72f843685a1672ebfe4bd21f
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    Two consecutive dots (..) is forbidden.
>> +
>> +commit bbf3f5926e11d97b08cdb6e833c9deb603453d1b
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    A/component/may/not/end/in/foo.lock
>> +
>> +commit 45e81b5163ec3ed656b058ac3fd95b8986824e0f
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    The sequence .lock/ is forbidden.
>> +
>> +commit eebb76e96913d2dc78aef5f233fadc74af770b3b
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    The sequence /. is forbidden.
>> +
>> +commit d4850419ccc1146c7169f500725ce504b9774ed0 (tag: base, master)
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    initial
>> +
>> +    Signed-off-by: Commiter Name <commiter@email>
>> +% list_files
>> +d .git/patches
>> +d .git/patches/master
>> +d .git/refs/patches
>> +d .git/refs/patches/master
>> +f 06beca7069b9e576bd431f65d13862ed5d3e2a0f  .git/patches/master/ctrlisforbidden.patch
>> +f 08267ec6783ea9d1adae55b275198f7594764ed0  .git/patches/master/series
>> +f 08267ec6783ea9d1adae55b275198f7594764ed0  .git/patches/master/status
>> +f 09b7e9be44ae5ec3a4bb30f5ee9d4ebc2c042f64  .git/patches/master/two_consecutive_dots_(.)_is_forbidden.patch
>> +f 0b971c9a17aeca2319c93d700ffd98acc2a93451  .git/patches/master/question-mark-is-forbidden.patch
>> +f 2b8392f63d61efc12add554555adae30883993cc  .git/patches/master/cannot-end-in-slash-.patch
>> +f 2cd7c9ad392e071be03c051c6793e9b1e31d33c4  .git/patches/master/can-have-embedded-single-slashes.patch
>> +f 3136e448a4c820f6d2642f9d894c4087d3d109ab  .git/patches/master/cannot_end_in_.patch
>> +f 34e07c584032df137f19bdb66d93f316f00a5ac8  .git/patches/master/tildeisforbidden.patch
>> +f 49bab499826b63deb2bd704629d60c7268c57aee  .git/patches/master/the_sequence_-._is_forbidden.patch
>> +f 5bcddb8ccb6e6e5e8a61e9e56cb2e0f70cbab2f5  .git/patches/master/cannot@have@the@sequence@at-brace.patch
>> +f 637b982fe14a240de181ae63226b27e0c406b3dc  .git/patches/master/asterisk-is-forbidden.patch
>> +f 698f8a7d41a64e3b6be1a3eba86574078b22a5f3  .git/patches/master/backslash-isorbidden.patch
>> +f 7b103c3c7ae298cd2334f6f49da48bae1424f77b  .git/patches/master/crisalsoforbidden.patch
>> +f 9b810b8c63779c51d2e7f61ab59cd49835041563  .git/patches/master/x.patch
>> +f a22958d9ae9976fd7b2b5a9d0bcd44bf7ad9b08a  .git/patches/master/caretisforbidden.patch
>> +f ab325bf5a432937fc6f231d3e8a773a62d53952b  .git/patches/master/multiple-slashes--are--forbidden.patch
>> +f cb9cffbd4465bddee266c20ccebd14eb687eaa89  .git/patches/master/delisforbidden.patch
>> +f d0885a1a1fdee0fd1e4fedce3f7acd3100540bc4  .git/patches/master/openbracketisforbidden.patch
>> +f d2903523fb66a346596eabbdd1bda4e52b266440  .git/patches/master/check-multiple-.-dots-.-foo.patch
>> +f dfc11f76394059909671af036598c5fbe33001ba  .git/patches/master/space_is_forbidden.patch
>> +f e47474c52d6c893f36d0457f885a6dd1267742bb  .git/patches/master/colon_is_forbidden.patch
>> +f e7a5f8912592d9891e6159f5827c8b4f372cc406  .git/patches/master/the_sequence_.lock-_is_forbidden.patch
>> +f edfaa5e06bd662ae1f6a642834324fd9b849bbd9  .git/patches/master/a-component-may-not-end-in-foolock.patch
>> +r 01524f9921af2a041cc88c068f76baa39e436cb2  .git/refs/patches/master/ctrlisforbidden.patch
>> +r 025672497aff5c910c8ff86aaedc662f14c2f4ad  .git/refs/patches/master/cannot-end-in-slash-.patch
>> +r 10433fd7206b7f79aabb4da514710d93c8deed4a  .git/refs/patches/master/colon_is_forbidden.patch
>> +r 1626a11d979a1e9e775c766484172212277153df  .git/refs/patches/master/asterisk-is-forbidden.patch
>> +r 3a0d5ccef0359004fcaa9cee98fbd6a2c4432e74  .git/refs/patches/master/tildeisforbidden.patch
>> +r 434e07cacdd8e7eb4723e67cb2d100b3a4121a3a  .git/refs/patches/master/can-have-embedded-single-slashes.patch
>> +r 74df14ab3a0ec9a0382998fbf167ebb1b0a36c6a  .git/refs/patches/master/question-mark-is-forbidden.patch
>> +r 7c3ffa4f940c862e9f11f5d4a5ae421f7a8d3141  .git/refs/patches/master/backslash-isorbidden.patch
>> +r 96a3e92c4df85f52362ce4f6d31983c462db9ae9  .git/refs/patches/master/a-component-may-not-end-in-foolock.patch
>> +r 9fc9677b61880f9159838e89f714893e0a2fcafb  .git/refs/patches/master/delisforbidden.patch
>> +r a275ed5d7f10ea88c986852ee95a7d5a61663b5f  .git/refs/patches/master/cannot@have@the@sequence@at-brace.patch
>> +r db6ea8252440b04811344336f510a5469b2ddab0  .git/refs/patches/master/check-multiple-.-dots-.-foo.patch
>> +r ea22c3b49c448dba8d7eaa6b805f9f1bc83fbedc  .git/refs/patches/master/space_is_forbidden.patch
>> +r ea46f435d4d8f3c5349dce1aabc1a39fbf7ef803  .git/refs/patches/master/x.patch
>> +r ec46429125abdb0c5ac2b46cc399bdcd7cfc73fd  .git/refs/patches/master/crisalsoforbidden.patch
>> +r edef5e925083d445f71c170d3293fac9619bc7a2  .git/refs/patches/master/openbracketisforbidden.patch
>> +r ee4f0f96dfc9c94f5410c1e6414f9004325a37fc  .git/refs/patches/master/the_sequence_.lock-_is_forbidden.patch
>> +r f091fee39457e64ebd35410c1cf95e6613816a54  .git/refs/patches/master/cannot_end_in_.patch
>> +r f13e243c7c56f39422567a431bccceec8b789596  .git/refs/patches/master/multiple-slashes--are--forbidden.patch
>> +r fb1edb753c97ec865ceea316420b1df586caaa2b  .git/refs/patches/master/caretisforbidden.patch
>> +r fdcb23c3072209bea3d9e0a2594132b936c5347e  .git/refs/patches/master/the_sequence_-._is_forbidden.patch
>> +r fe07105cd62660f4440ad24b9fc7dfdd9e71d764  .git/refs/patches/master/two_consecutive_dots_(.)_is_forbidden.patch
>> +% guilt pop -a
>> +All patches popped.
>> diff --git a/regression/t-034.sh b/regression/t-034.sh
>> new file mode 100755
>> index 0000000..f41f958
>> --- /dev/null
>> +++ b/regression/t-034.sh
>> @@ -0,0 +1,71 @@
>> +#!/bin/bash
>> +#
>> +# Test import-commit
>> +#
>> +
>> +function create_commit
>> +{
>> +     echo $1 >> $1 &&
>> +             git add $1 &&
>> +             git commit -m"$2"
>> +}
>> +
>> +source "$REG_DIR/scaffold"
>> +
>> +b()
>> +{
>> +     printf "%b" "$1"
>> +}
>> +
>> +cmd setup_git_repo
>> +
>> +cmd git tag base
>> +
>> +# Create a series of commits whose first line of the commit message
>> +# each violates one of the rules in get-check-ref-format(1).
>> +
>> +cmd create_commit a "The sequence /. is forbidden."
>> +cmd create_commit a "The sequence .lock/ is forbidden."
>> +cmd create_commit a "A/component/may/not/end/in/foo.lock"
>> +cmd create_commit a "Two consecutive dots (..) is forbidden."
>> +cmd create_commit a "Check/multiple/../dots/...../foo..patch"
>> +cmd create_commit a "Space is forbidden."
>> +cmd create_commit a "Tilde~is~forbidden."
>> +cmd create_commit a "Caret^is^forbidden."
>> +cmd create_commit a "Colon:is:forbidden."
>> +cmd create_commit a `b 'Del\177is\177forbidden.'`
>> +# Create a branch and a tag from the current commit, to ensure that
>> +# doing so does not affect how the commit is imported.
>> +cmd git branch some-branch
>> +cmd git tag some-tag
>> +cmd create_commit a `b 'Ctrl\001is\002forbidden.'`
>> +cmd create_commit a `b 'CR\ris\ralso\rforbidden.'`
>> +cmd create_commit a "Question-mark?is?forbidden."
>> +cmd create_commit a "Asterisk*is*forbidden."
>> +cmd create_commit a "Open[bracket[is[forbidden."
>> +cmd create_commit a "Multiple/slashes//are//forbidden."
>> +cmd create_commit a "Cannot/end/in/slash/"
>> +cmd create_commit a "Cannot end in .."
>> +cmd create_commit a "Cannot@{have@{the@{sequence@{at-brace."
>> +cmd create_commit a "@"
>> +cmd create_commit a "Backslash\\is\\forbidden."
>> +
>> +# Slash is sometimes allowed; this is not problematic.
>> +cmd create_commit a "Can/have/embedded/single/slashes"
>> +
>> +cmd git log
>> +
>> +# Import all the commits to guilt.
>> +cmd guilt init
>> +cmd guilt import-commit base..HEAD
>> +
>> +for patch in .git/patches/master/*.patch; do
>> +     touch -a -m -t "$TOUCH_DATE" "$patch"
>> +done
>> +
>> +# If push and pop works, the names we created are good.
>> +cmd guilt push -a
>> +cmd git log --decorate
>> +cmd git log --decorate some-branch
>> +cmd list_files
>> +cmd guilt pop -a
>> --
>> 1.8.3.1
>>
>
> --
> C is quirky, flawed, and an enormous success.
>                 - Dennis M. Ritchie.
