From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/4] submodule: fix recursive path printing from non root directory
Date: Fri, 25 Mar 2016 09:54:11 -0700
Message-ID: <CAGZ79kYmVH_6=7y894woObaD4de44d8iUQtcCq6r3grGrMiaxQ@mail.gmail.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
	<1458862468-12460-2-git-send-email-sbeller@google.com>
	<xmqqy4964if7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jacob Keller <jacob.keller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 17:54:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajV03-00084E-Vd
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 17:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbcCYQyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 12:54:13 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:35489 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbcCYQyM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 12:54:12 -0400
Received: by mail-io0-f181.google.com with SMTP id v187so88717722ioe.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 09:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Pb9nA3Vx7hwbbwLp4xVXZ33E+T+/6UxQThxT6NnhCu4=;
        b=o2Ix/jHhB5s1W3LWQ5Lg2erjDBIYZB2G4W8nKrXyw5EWK+G88kTrz8zh6Ls+PZOCW9
         7Mvi2JncSw/AN0kaFgQHZhd3zn1tjurou2TRmMvuxeDRoYR4pNCSRFUl6JU1NFzzQnZS
         OhqjXSIsAD6hdVRYhiq3lzBQp3vG1GAkSisUs4oKMjfyLkrK/ecDZjxBV5FL7qutIsZz
         RkTgu3Q6RNL2yKCNAOJPM/M2StZ1MyqmmiPwIvMULvuLXDf1gfWJ7j+aiS1lzkY8kqYc
         Fo003jlZKQiB5uqs+0kzeA8y+DkGcCluBXvRTLxZny6BLM/MrcYeD2vvoGaGArKFr6mP
         jHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Pb9nA3Vx7hwbbwLp4xVXZ33E+T+/6UxQThxT6NnhCu4=;
        b=ctv0CqkQI5gWWMxV83pyKIIOySx9ciG1MXmLDPKSflQ2m6ss/r4HhXYxkIwCiOAGPi
         LgZe2JhoBGNSvRBywu64S6XW5NJyf46jLvamv+76Zz7i66V/sz1UClbTKr8YQreFe3I+
         c+BJsQMivHGr8eLpfimMszB4ZHsRINstt1SpVFo3rhU38T/SGbnOkUxCKTm/k8DOPgms
         7/0HBK1mKcAZriA1U05yPUTx/cDT4Fui29wbIPrnodJ/gPhyu+hBrNvfcqH03FViM5G1
         APCi7PWR9SQe2DNfUkLZ8E8i3aVnELZrH92oPjcKroPHhiCYdphzschIbRU4mdqZ+fdk
         YpWw==
X-Gm-Message-State: AD7BkJLYJ7N/kkTfCijpRNbIi3P93OAcgNqQjdRJ5WEW+DZvrz/kMQ6+4dAIOCcqnBjZykGeSSkVKBy44OjKxdEE
X-Received: by 10.107.131.163 with SMTP id n35mr16819094ioi.110.1458924851353;
 Fri, 25 Mar 2016 09:54:11 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Fri, 25 Mar 2016 09:54:11 -0700 (PDT)
In-Reply-To: <xmqqy4964if7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289905>

On Fri, Mar 25, 2016 at 9:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Recursing into submodules currently works by just calling
>> (cd $submodule && eval <command>) for update, sync and status
>> command.
>>
>> Say you have the following setup
>>
>> repo/ # a superproject repository
>> repo/untracked/ # an untracked dir in repo/
>> repo/sub/ # a submodule
>> repo/sub/subsub # a submodule of a submodule
>>
>> When being in repo/untracked/ and invoking "git submodule status"
>> you would expect output like:
>>
>>     repo/untracked/$ git submodule status --recursive
>>      <sha1> ../sub (version)
>>      <sha1> ../sub/subsub (<version>)
>>
>> We need to take into account that we are in the untracked/ dir,
>> so we need to prepend ../ to the paths. By using relative_path
>> to compute the prefix, we'll have that output.
>
> tests to demonstrate existing breakage and protect the fix from
> future breakages would be needed, no?

I realize this is worded slightly wrong. The bugs described in patch
1&2 would only occur if we'd apply patch 3 without them.
So currently there is no bug.

We currently do have tests for that, e.g. t7403,
 '"git submodule sync" should update submodule URLs - subdirectory'

In patch 4 I added tests for "git submodule update" and enhanced tests for
the sync command.


>
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  git-submodule.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 43c68de..536ba68 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -825,7 +825,7 @@ Maybe you want to use 'update --init'?")"
>>               if test -n "$recursive"
>>               then
>>                       (
>> -                             prefix="$prefix$sm_path/"
>> +                             prefix="$(relative_path $prefix$sm_path)/"
>>                               clear_local_git_env
>>                               cd "$sm_path" &&
>>                               eval cmd_update
>> @@ -1233,13 +1233,13 @@ cmd_sync()
>>                       then
>>                       (
>>                               clear_local_git_env
>> +                             prefix=$(relative_path "$prefix$sm_path/")
>>                               cd "$sm_path"
>>                               remote=$(get_default_remote)
>>                               git config remote."$remote".url "$sub_origin_url"
>>
>>                               if test -n "$recursive"
>>                               then
>> -                                     prefix="$prefix$sm_path/"
>>                                       eval cmd_sync
>>                               fi
>>                       )
