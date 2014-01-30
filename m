From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [ANNOUNCE] Git v1.9-rc0
Date: Fri, 31 Jan 2014 03:50:45 +0530
Message-ID: <52EAD03D.5050802@gmail.com>
References: <xmqq61pjzljn.fsf@gitster.dls.corp.google.com> <xmqqha8xt22p.fsf@gitster.dls.corp.google.com> <20140127175953.GA18041@camk.edu.pl> <20140127185829.GE27577@google.com> <20140128122851.GA1102@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kacper Kornet <kornet@camk.edu.pl>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 23:20:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8zyh-0005Lo-No
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 23:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbaA3WUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 17:20:52 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63473 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbaA3WUv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 17:20:51 -0500
Received: by mail-pa0-f46.google.com with SMTP id rd3so3650759pab.5
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 14:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Jl4zOV2/2xhvritePXPVu6FIdfp3lvQE/1HxwQOPJPI=;
        b=D3Rj7CbY/x4RxQjH6Ab2vN95S5s4qhdNgMG4jc1YqWC6VwAVP51iQk5NmZAErTcekz
         QvKyVucqN7wLaHi1ZxySLFIpqd1htdljVyT33moxXzoF0R8ay2sdoqhbLGgCNyKQiB+l
         Zw78AZqz+jqeJnYjOZs6SDl78mu516DSfNHkx/9mDderu5evjelfNMbyKXB1pRXoKGAT
         M2g3dgRxJlWLtDAf+OyENizFrWszmY7W1J0Qf4sKiasLkC5w++cnAYYtwKfiivZaPjqd
         QXYO4JrdAK7ctWKrzxgx0Y7M8PxritqV5dWNufKauk/uROMZVKf2NPN6hpELBtMi13bv
         ObIw==
X-Received: by 10.68.171.193 with SMTP id aw1mr16896987pbc.117.1391120450623;
        Thu, 30 Jan 2014 14:20:50 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.195.161.181])
        by mx.google.com with ESMTPSA id da3sm20851510pbc.30.2014.01.30.14.20.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 30 Jan 2014 14:20:49 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140128122851.GA1102@camk.edu.pl>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241284>

On 01/28/2014 05:58 PM, Kacper Kornet wrote:
> On Mon, Jan 27, 2014 at 10:58:29AM -0800, Jonathan Nieder wrote:
>> Hi,
> 
>> Kacper Kornet wrote:
> 
>>> The change in release numbering also breaks down gitolite v2 setups. One
>>> of the gitolite commands, gl-compile-conf, expects the output of git --version 
>>> to match /git version (\d+)\.(\d+)\.(\d+)/. 
> 
>>> I have no idea how big problem it is, as I don't know how many people
>>> hasn't migrate to gitolite v3 yet. 
> 
>> http://qa.debian.org/popcon.php?package=gitolite says there are some.
>> I guess soon we'll see if there are complaints.
> 
>> http://gitolite.com/gitolite/migr.html says gitolite v2 is still
>> maintained.  Hopefully the patch to gitolite v2 to fix this would not
>> be too invasive --- e.g., how about this patch (untested)?
> 
>> Thanks,
>> Jonathan
> 
>> diff --git i/src/gl-compile-conf w/src/gl-compile-conf
>> index f497ae5..8508313 100755
>> --- i/src/gl-compile-conf
>> +++ w/src/gl-compile-conf
>> @@ -394,8 +394,9 @@ die "
>>      the server.  If it is not, please edit ~/.gitolite.rc on the server and
>>      set the \$GIT_PATH variable to the correct value\n
>>  " unless $git_version;
>> -my ($gv_maj, $gv_min, $gv_patchrel) = ($git_version =~ m/git version (\d+)\.(\d+)\.(\d+)/);
>> +my ($gv_maj, $gv_min, $gv_patchrel) = ($git_version =~ m/git version (\d+)\.(\d+)\.([^.-]*)/);
>>  die "$ABRT I can't understand $git_version\n" unless ($gv_maj >= 1);
>> +$gv_patchrel = 0 unless ($gv_patchrel =~ m/^\d+$/);
>>  $git_version = $gv_maj*10000 + $gv_min*100 + $gv_patchrel;  # now it's "normalised"
> 
>>  die "\n\t\t***** AAARGH! *****\n" .
> 
> It works for 1.9.rc1 but I think it will fail with final 1.9. The
> following version should be ok:
> 
> diff --git a/src/gl-compile-conf b/src/gl-compile-conf
> index f497ae5..c391468 100755
> --- a/src/gl-compile-conf
> +++ b/src/gl-compile-conf
> @@ -394,7 +394,7 @@ die "
>      the server.  If it is not, please edit ~/.gitolite.rc on the server and
>      set the \$GIT_PATH variable to the correct value\n
>  " unless $git_version;
> -my ($gv_maj, $gv_min, $gv_patchrel) = ($git_version =~ m/git version (\d+)\.(\d+)\.(\d+)/);
> +my ($gv_maj, $gv_min, undef, $gv_patchrel) = ($git_version =~ m/git version (\d+)\.(\d+)(\.(\d+))?/);
>  die "$ABRT I can't understand $git_version\n" unless ($gv_maj >= 1);
>  $git_version = $gv_maj*10000 + $gv_min*100 + $gv_patchrel;  # now it's "normalised"

Gitolite v3 will be 2 years old in a month or so.  I would prefer to use
this as an opportunity to encourage people to upgrade; v2 really has
nothing going for it now.

People who cannot upgrade gitolite should simply cut that whole block
of code and throw it out.  Distro's should probably do that if they are
still keeping gitolite v2 alive, because it is clearly not needed if the
same distro is up to 1.9 of git!

My policy has been to continue support for critical bugs.  A bug that
can be fixed by simply deleting the offending code block, with no harm
done, is -- to my mind -- not critical enough :-)

side note, Kacper: I'd use non-capturing parens than an undef in the
destination list.
