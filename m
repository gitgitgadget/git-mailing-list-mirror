From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH v1 08/19] rebase -i: root commits are replayed with an
 unnecessary option
Date: Mon, 04 Aug 2014 23:31:51 +0200
Message-ID: <53DFFBC7.2070902@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com> <7ed1b44ae05860a556d86c8b90ac6fff0906128d.1406589435.git.bafain@gmail.com> <20140802001322.GC20040@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 23:32:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEPrN-0004ZP-G2
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 23:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbaHDVb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 17:31:57 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:41808 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbaHDVb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 17:31:56 -0400
Received: by mail-wg0-f48.google.com with SMTP id x13so37946wgg.7
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 14:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=JT7nqiCdKI0dIDOx2jW0aVzPUQ0V8hVsTG4E72YA5U0=;
        b=IbxhU+OjmJjnsDfpbp/rW0mN1NQ7q0FcakfU9hwIFR+TvKAOBYq3ksbLlDTX68qSaC
         abVFtBaMTfcgsMkIVrHQS0tTXESjZ4/zIlsgFUz+iZHn+EQ9Hux4nor5rdo5sG+anlav
         Za1MOkg7W6Y28tz/UOFLDJrD1ErWg8BSrTYaNgaTYupVu+JvIGbKT9s8PsqbWsUXrylG
         jqs8xT4LAGTuEqBpVYDCoWrEXg1rWP4woF9eXQQktYTSXKJKYPHGXbQOaJEyVGPl9ozE
         ihWWL5pSfL60gh9kdiBWKzVikfSGKUMtlhRdeZsh3C7ZInwwOMgioF4iv/v9o6a9H9XK
         QS0w==
X-Received: by 10.194.172.137 with SMTP id bc9mr36309690wjc.72.1407187915375;
        Mon, 04 Aug 2014 14:31:55 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id o2sm851317wij.24.2014.08.04.14.31.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 14:31:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140802001322.GC20040@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254786>

Hi Jeff,

Jeff King writes:
> On Tue, Jul 29, 2014 at 01:18:08AM +0200, Fabian Ruch wrote:
>> The command line used to recreate root commits specifies the
>> effectless option `-C`. It makes git-commit reuse commit message and
>> authorship of the named commit. However, the commit being amended
>> here, which is the sentinel commit, already carries the authorship
>> and log message of the commit being replayed. Remove the option.
>>
>> Since `-C` (in contrast to `-c`) does not invoke the editor and the
>> `--amend` option invokes it by default, disable editor invocation
>> again by specifying `--no-edit`.
> 
> I found this description a little backwards. The "-C" does have an
> effect, as you noticed in the second paragraph.
> 
> I think the reasoning is more like:
> 
>   The command line used to recreate root commits uses "-C" to
>   suppress the commit editor. This is unnecessarily confusing,
>   though, because that suppression is a secondary effect of the
>   option. The main purpose of "-C" is to pull the metadata from
>   another commit, but here we know that this is a noop, since we
>   are amending a commit just created from the same data.
> 
>   At the time, commit did not yet know "--no-edit", and this was a
>   reasonable way to get the desired behavior. We can switch it to
>   use "--no-edit" to make the intended effect more obvious.

Thanks again, I shamelessly copied your formulation but squeezed in an
"undocumented" because --no-edit had just been implemented (commit
ca1ba2010), though was then still missing from the git-commit manpage.

    Fabian
