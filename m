From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH, RFC] checkout: Attempt to checkout submodules
Date: Mon, 23 Mar 2015 21:01:48 +0100
Message-ID: <5510712C.5090906@web.de>
References: <1426681643-7516-1-git-send-email-tbsaunde@tbsaunde.org> <xmqqy4msizu1.fsf@gitster.dls.corp.google.com> <20150319201509.GB21536@tsaunders-iceball.corp.tor1.mozilla.com> <xmqq3850it94.fsf@gitster.dls.corp.google.com> <20150320001345.GC21536@tsaunders-iceball.corp.tor1.mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Trevor Saunders <tbsaunde@tbsaunde.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 21:02:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya8Xz-0004sj-EK
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 21:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbbCWUB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 16:01:59 -0400
Received: from mout.web.de ([212.227.15.3]:63307 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752552AbbCWUB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 16:01:58 -0400
Received: from [192.168.178.41] ([79.211.96.44]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LlWRb-1ZBP2I22R5-00bIFf; Mon, 23 Mar 2015 21:01:49
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150320001345.GC21536@tsaunders-iceball.corp.tor1.mozilla.com>
X-Provags-ID: V03:K0:GTEJN9nfinQnfq30zTkrZ4gjo7QkjJ2e7KTOEE6MeViH4fkn4SM
 U5GjETuCL/c0sx2oZNeldB6uNtLdt3qPjzke4HvVACNy9EPMWiEpMfJnlWB00MvD9BaaVRM
 wgKFXCsnw5j37oXJV/TdLgTU36Ui5wfycqTdwRM3CjKf4H7cm2sJbcn03SOjKjG2ckcukVi
 78dZ1R5VEN9Bn7hI7qyfg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266161>

Am 20.03.2015 um 01:13 schrieb Trevor Saunders:
> On Thu, Mar 19, 2015 at 02:15:19PM -0700, Junio C Hamano wrote:
>> Trevor Saunders <tbsaunde@tbsaunde.org> writes:
>> I have a feeling that an optional feature that allows "git submodule
>> update" to happen automatically from this codepath might be
>> acceptable by the submodule folks, and they might even say it does
>> not even have to be optional but should be enabled by default.
>
> ok, that seems fairly reasonable.  I do kind of wonder though if it
> shouldn't be 'git submodule update --checkout' but that would get us
> kind of back to where we started.  I guess since the default is checkout
> if you set the pref then you can be assumed to have some amount of idea
> what your doing.

Me thinks it should be "git checkout" for those submodules that have
their update setting set to 'checkout' (or not set at all). I'm not
sure yet if it makes sense to attempt a rebase or merge here, but that
can be added later if necessary.

>> But I do not think it would fly well to unconditionally run
>> "checkout -f" here.
>
> agreed

Using -f here is ok when you extend the appropriate verify functions
in unpack-trees.c to check that no modifications will be lost (unless
the original checkout is used with -f). See the commit 76dbdd62
("submodule: teach unpack_trees() to update submodules") in my github
repo at https://github.com/jlehmann/git-submod-enhancements for
the basic concept (There is already a fixup! for that a bit further
down the branch which handles submodule to file conversion, maybe one
or two other changes will be needed when the test suite covers all
relevant cases).
