From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Case rename not detected
Date: Wed, 06 May 2015 22:00:43 +0200
Message-ID: <554A72EB.9000605@web.de>
References: <CAGHpTBJuRCrg5jL7Anm9kxGJEf5cUmPzDToZG0UXeT_xNMWfsg@mail.gmail.com>	<xmqqzj5jeeek.fsf@gitster.dls.corp.google.com> <CAGHpTBLMDaKUFVwbeqhKitYLL6Ufp7EkPRc5mjq7yN2gE=RmUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Orgad Shaneh <orgads@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 22:01:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq5Vg-00073s-Tv
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 22:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbbEFUBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 16:01:32 -0400
Received: from mout.web.de ([212.227.15.4]:61830 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730AbbEFUBc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 16:01:32 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0Lud96-1ZGWOM0W5g-00zo5i; Wed, 06 May 2015 22:01:26
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAGHpTBLMDaKUFVwbeqhKitYLL6Ufp7EkPRc5mjq7yN2gE=RmUg@mail.gmail.com>
X-Provags-ID: V03:K0:J6DTe5RHbTvNwN2QOQ+Sm5LVV8HVCZQHnv/iTI/TRwUkmRrChJ5
 KSnXZ68YIlEJ23AeGunPT5o30AvTAWgaYj4tS8c8q95+7OyHwGdhLULbfhaj5EevltleRM6
 kgAV0KS/WAqvliacU2WOKYEzKaZywWgBOy3t6teKMIdZNIzCvmV1sGQc+h4hD8HwogLC3XO
 SUHTCuky/BEcStf9Hipkw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268491>

On 2015-05-05 08.27, Orgad Shaneh wrote:
> Thanks for the fast response!
> 
> On Tue, May 5, 2015 at 9:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Orgad Shaneh <orgads@gmail.com> writes:
>>
>>> File case rename is not detected correctly on case-insensitive
>>> filesystems. git mv does support it though.
>>
>> It is a very much deliberate design decision to keep the case
>> recorded in the index on case insensitive filesystems, where people
>> can screw up the case of files they obtained from the project
>> without even meaning to do so, as these filesystems and tools on
>> them can carelessly change cases---after all, the case doesn't
>> matter to these tools, but the people who interact with your work
>> result via Git do---so we trust what Git initially gave you
>> (e.g. via "checkout") more than the filesystem.
> 
> Can you name tools that change file case without notifying the user?
> I'm not aware of any.
> 
>>
>> To effect the same as "git mv" at the end-user level, you would need
>> to remove the entry from the index and re-add it.  I.e.
>>
>>> git init
>>> echo hello > foo
>>> git add foo
>>> git commit -m initial
>>> mv foo Foo
>>> git status # No changes
You can use 
git -c core.ignorecase=false status

It will report Foo as untracked

foo is not reported as missing, because the underlying OS
says "foo" is there when Git does a stat("Foo")
