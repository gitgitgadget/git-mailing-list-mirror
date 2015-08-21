From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] contrib: teach completion about git-worktree options and arguments
Date: Fri, 21 Aug 2015 10:21:03 -0700
Message-ID: <xmqq37zc7e2o.fsf@gitster.dls.corp.google.com>
References: <1437684550-21884-1-git-send-email-sunshine@sunshineco.com>
	<CAPig+cQhh7YCiirp4a1+R0bWh46JoFgVOVUCNidTWXK8uNL2Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Aug 21 19:21:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSq07-0006GB-Ef
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 19:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbbHURVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 13:21:07 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35402 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbbHURVF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 13:21:05 -0400
Received: by pdob1 with SMTP id b1so28721672pdo.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 10:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=erKl5CaFcOJtgd+fjrD+g8oCaw7Yx9kN/KvmEfX3AOI=;
        b=GS3eb63v7RgYRfPHPRdomv+/Y5kDwski9LDUfuprJHlgs+LeQ9hewW20j6FpEsiknZ
         PTZ6qf7lWneQMDn0K3SZFWg3gAg+D5UdaM7CprfeWzV8iK/jfwZWWH202JcNQf3S5Rvf
         gVaWr8yjUcTmXZm2i/zso5LRrxRH+tgV0o2ZdcdcXimC0hCKluIwFd0Xy30+37zr7h6n
         FlR6thfsLJbBfT0zibMbuvJZNs8OVTiTT5HNTNFq8jiud437p8MvMjRp1mZq7dKVJNEU
         PSujXX7yLqHpPeDm1vnvW0bsAaLm+PV38rOo2QLXmvDcj6Pd7I9CvFWRo8bA9ySCxakP
         2rcA==
X-Received: by 10.70.20.196 with SMTP id p4mr19262641pde.58.1440177664749;
        Fri, 21 Aug 2015 10:21:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c7d:6904:6af7:82e1])
        by smtp.gmail.com with ESMTPSA id c12sm8464349pdk.47.2015.08.21.10.21.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 10:21:03 -0700 (PDT)
In-Reply-To: <CAPig+cQhh7YCiirp4a1+R0bWh46JoFgVOVUCNidTWXK8uNL2Mg@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 6 Aug 2015 12:29:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276315>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Jul 23, 2015 at 4:49 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Complete subcommands 'add' and 'prune', as well as their respective
>> options --force, --detach, --dry-run, --verbose, and --expire. Also
>> complete 'refname' in "git worktree add [-b <newbranch>] <path>
>> <refname>".
>
> Ping[1]?
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/274526

Ping indeed?

>
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>> ---
>>
>> This is RFC since this is my first foray into the Git completion script,
>> and there are likely better and more idiomatic ways to accomplish this.
>>
>>  contrib/completion/git-completion.bash | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index c97c648..07c34ef 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2564,6 +2564,38 @@ _git_whatchanged ()
>>         _git_log
>>  }
>>
>> +_git_worktree ()
>> +{
>> +       local subcommands='add prune'
>> +       local subcommand="$(__git_find_on_cmdline "$subcommands")"
>> +       local c=2 n=0 refpos=2
>> +       if [ -z "$subcommand" ]; then
>> +               __gitcomp "$subcommands"
>> +       else
>> +               case "$subcommand,$cur" in
>> +               add,--*)
>> +                       __gitcomp "--force --detach"
>> +                       ;;
>> +               add,*)
>> +                       while [ $c -lt $cword ]; do
>> +                               case "${words[c]}" in
>> +                               --*) ;;
>> +                               -[bB]) ((refpos++)) ;;
>> +                               *) ((n++)) ;;
>> +                               esac
>> +                               ((c++))
>> +                       done
>> +                       if [ $n -eq $refpos ]; then
>> +                               __gitcomp_nl "$(__git_refs)"
>> +                       fi
>> +                       ;;
>> +               prune,--*)
>> +                       __gitcomp "--dry-run --verbose --expire"
>> +                       ;;
>> +               esac
>> +       fi
>> +}
>> +
>>  __git_main ()
>>  {
>>         local i c=1 command __git_dir
>> --
>> 2.5.0.rc3.407.g68aafd0
