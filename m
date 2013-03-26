From: Eric Cousineau <eacousineau@gmail.com>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be depth-first,
 --parent option to execute command in supermodule as well
Date: Mon, 25 Mar 2013 23:36:30 -0500
Message-ID: <515125CE.3020101@gmail.com>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com> <51351CF5.7010308@web.de> <7vhakqwz1e.fsf@alter.siamese.dyndns.org> <20130305075901.GB4677@sandbox-ub> <7vhakpvnex.fsf@alter.siamese.dyndns.org> <CA+aSAWvQj2wuJX3ENNn7n_pMJjA6nauve5BLRugiTuhWN25Ctg@mail.gmail.com> <7vboaxu23y.fsf@alter.siamese.dyndns.org> <51365AB6.2010602@web.de> <CABURp0psgofX=ean+KKooN74pF4Ns-gDGt68vc5Exs6NmDRUyw@mail.gmail.com> <513B7D08.20406@web.de> <CABURp0qBA6myf7_SuaxJSrePJHmh2v-nmtLRzKTtgAJxLkJ-tQ@mail.gmail.com> <514782D3.5060200@web.de> <51511C62.3080704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Lars Hjemli <hjemli@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 26 05:37:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKLdA-0004Vx-0p
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 05:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932850Ab3CZEgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 00:36:35 -0400
Received: from mail-gh0-f169.google.com ([209.85.160.169]:43216 "EHLO
	mail-gh0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932469Ab3CZEge (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 00:36:34 -0400
Received: by mail-gh0-f169.google.com with SMTP id r18so550111ghr.14
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 21:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=JI5MwLdO2TeIHjc0VOQGlU3VaeBwRJCi17xcwwlVVD0=;
        b=KXU1b5ncL4cLGj65lU0Gu49A0iXkNLhmAsyg/lY/ELTCF9L+qM1ZP14hMU/oMZSHiw
         1deUPC0sXrqaFRsdhX8+ut/nUGNEn+9MQj3uOtvv/ubADaNv0s3lupn0UsZpTayeQCd4
         zCsAyVsgtJEO7NWQmyjp1BcRqg2Eg+G1wRLBF8mEs57jauruDtzOGta5gzmtNSQLu7ju
         VXoNYu1ZzbgvwnPw58Uy840Ybr/wIsQTgJyBtCwhj/wtlZc34edI6m8prsL7yUGepB6N
         VWInil9Ft+bYJTQIowcbF/FPfZhu6aXn0ihf86aVB3lDPQahCZU7b1FuueAxMrbNoShJ
         w4fQ==
X-Received: by 10.236.20.34 with SMTP id o22mr8694016yho.78.1364272593484;
        Mon, 25 Mar 2013 21:36:33 -0700 (PDT)
Received: from [10.3.2.6] ([199.30.163.2])
        by mx.google.com with ESMTPS id h24sm23242062yhc.25.2013.03.25.21.36.31
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 25 Mar 2013 21:36:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <51511C62.3080704@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219133>

On 03/25/2013 10:56 PM, Eric Cousineau wrote:
> On 03/18/2013 04:10 PM, Jens Lehmann wrote:
>> Am 12.03.2013 17:01, schrieb Phil Hord:
>>> On Sat, Mar 9, 2013 at 1:18 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>>> Am 05.03.2013 22:17, schrieb Phil Hord:
...
>>
>> I agree on the possible problems a configuration option introduces.
>>
>>>> I'm still not convinced we should add a new switch, as it can easily
>>>> be achieved by adding "${cmd} &&" to your scripts. And on the command
>>>> line you could use an alias like this one to achieve that:
>>>>
>>>> [alias]
>>>>           recurse = !sh -c \"$@ && git submodule foreach --recursive $@\"
>>>
>
> I tried this and the 'recurse-post' alias, but could not get it to function as
> it does inside of 'git submodule foreach'. I also tried out some different escaping
> methods, but nothing seemed to work. I've added the examples below.
>
>>> Yes, making the feature itself a 2nd-class citizen.  :-)
>>>
>>> But this alias also denies me the benefit of the --post-order option.
>>> For 'git recurse git push', for example, I wouldn't want the
>>> superproject push to occur first; I would want it to occur last after
>>> the submodules have been successfully pushed.
>>
>> [alias]
>>            recurse-post = !sh -c \"git submodule foreach --recursive --post-order $@ && $@\"
>> ;-)
>>
>>> I agree this should go in some other commit, but I do not think it is
>>> so trivial it should never be considered as a feature for git.  That's
>>> all I'm trying to say.
>>
>> I am not against adding such a functionality to Git, I'm just not
>> convinced "git submodule foreach" is the right command for that. I
>> suspect the "git for-each-repo" Lars proposed earlier this year might
>> be a better choice, as that could also recurse into other repos which
>> aren't registered as submodules. And a "for-each-repo" to me looks
>> like a command which could include the superproject too (at least when
>> told to do so with an option).
>>
>
> Here are the aliases I am using:
>
> [alias]
> 	recurse = !sh -c \"$@ && git submodule foreach --recursive $@\"
> 	recurse-post = !sh -c \"git submodule foreach --recursive --post-order $@ && $@\"
> 	fer = !sh -c \"eval \\\"$@\\\" && git submodule foreach --recursive \\\"$@\\\"\"
> 	ferpo = !sh -c \"git submodule foreach --recursive --post-order \\\"$@\\\" && eval \\\"$@\\\"\"
> 	fers = !sh -c \"eval '$@' && git submodule foreach --recursive '$@'\"
> 	ferpos = !sh -c \"git submodule foreach --recursive --post-order '$@' && eval '$@'\"
>
> And these are the results I get with the following example:
>
> $ cmd="echo \"'ello world: \$PWD\""
> $ eval "$cmd"
> 'ello world: /tmp/a
> $ git submodule foreach --recursive "$cmd"
> Entering 'b'
> 'ello world: /tmp/a/b
> Entering 'b/d'
> 'ello world: /tmp/a/b/d
> Entering 'c'
> 'ello world: /tmp/a/c
> $ git submodule foreach --recursive --post-order "$cmd" "$cmd"
> Entering 'b'
> 'ello world: /tmp/a/b
> Entering 'b/d'
> 'ello world: /tmp/a/b/d
> Exiting 'b/d'
> 'ello world: /tmp/a/b/d
> Exiting 'b'
> 'ello world: /tmp/a/b
> Entering 'c'
> 'ello world: /tmp/a/c
> Exiting 'c'
> 'ello world: /tmp/a/c
> $ git recurse "$cmd"
> 'ello world: /tmp/a
> Entering 'b'
> /home/eacousineau/local/lib/git/libexec/git-core/git-submodule: 1: eval: Syntax error: Unterminated quoted string
> Stopping at 'b'; script returned non-zero status.
> $ git recurse-post "$cmd"
> Entering 'b'
> /home/eacousineau/local/lib/git/libexec/git-core/git-submodule: 1: eval: Syntax error: Unterminated quoted string
> Stopping at 'b'; script returned non-zero status.
> $ git fer "$cmd"
> ello world: /tmp/a
> Entering 'b'
> ello world: /tmp/a
> Entering 'b/d'
> ello world: /tmp/a
> Entering 'c'
> ello world: /tmp/a
> $ git ferpo "$cmd"
> Entering 'b'
> /home/eacousineau/local/lib/git/libexec/git-core/git-submodule: 1: eval: world:: not found
> Stopping at 'b'; script returned non-zero status.
> Stopping at 'b'; script returned non-zero status.
> $ git fers "$cmd"
> ello world: /tmp/a' && git submodule foreach --recursive 'echo ello world: /tmp/a
> $ git ferpos "$cmd"
> Entering 'b'
> /home/eacousineau/local/lib/git/libexec/git-core/git-submodule: 1: eval: Syntax error: Unterminated quoted string
> Stopping at 'b'; script returned non-zero status.
>
> The problem is trying to escape with double-quotes, where the single-quotes are evaluated
> as a shell token thing and not as a string argument, versus single-quotes, where you cannot (easily) escape single
> quotes inside of it (though please correct me if I'm wrong!).
> It seems the best solution would be to have it as a script to allow recursion to occur in the scope of one script,
> like submodule foreach.
>
> I understand now why it does not fit in the scope of 'git submodule', though, so I could implement it as a *very*
> lightweight stand-in for Lars's "git for-each-repo" via some copy-and-paste :P
>
> - Eric
>

Put together a script with the --include-super functionality, named it 
'git-fer.sh' to start.
Posted as a Gist: https://gist.github.com/eacousineau/5243161

That test case:

$ git-fer --include-super --recursive --post-order "$cmd" "$cmd"
Entering supermodule 'a'
'ello world: /tmp/a
Entering 'b'
'ello world: /tmp/a/b
Entering 'b/d'
'ello world: /tmp/a/b/d
Exiting 'b/d'
'ello world: /tmp/a/b/d
Exiting 'b'
'ello world: /tmp/a/b
Entering 'c'
'ello world: /tmp/a/c
Exiting 'c'
'ello world: /tmp/a/c
Exiting supermodule 'a'
'ello world: /tmp/a
