From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv8 5/9] submodule-config: introduce parse_generic_submodule_config
Date: Fri, 5 Feb 2016 17:36:02 -0800
Message-ID: <CAGZ79kY4=wQvK1nn0Nv+qbR+n1=aqtY31EGwoHszG=jHP-iNTg@mail.gmail.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
	<1454623776-3347-6-git-send-email-sbeller@google.com>
	<20160206012306.GD28749@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 02:36:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRrnF-0007mg-Tw
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 02:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbcBFBgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 20:36:05 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34002 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbcBFBgE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 20:36:04 -0500
Received: by mail-ig0-f181.google.com with SMTP id ik10so53231025igb.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 17:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AKP+JWUEkEz8uNDxxoMEcy2/npy1CDFHbBjOywRncvk=;
        b=iSNoM+BJFI4GH1XLWU546c+b+2Jac4GsxCGIUoDOcWAZAYfZnNhVSNOw8tWYzKOZq5
         ZybORADHfcpQL3xFjn8ZxGw+9GU9G8ezRDRvRYNlQxjYAVPh0ZN3wTgmc0RGuiolgT//
         fXZlXnr6I/xBBCyeofNEqhBl8BJ/BQ4UmCqavUFx6con+Hv3fd7l+X+4lvPDWqHpCp8D
         FG6Zw52bbbSY8tzaUTOxcE0SIT+LR/INITFfFNXlgMgm0eOaaARAwn37SKIF6ZTnY1Nu
         cjuLOYultqDUAZzej0ctjhn0ICU8WD5Z8Kjo5DJ5VnDs33qUnPwUMRdQMV0ljBfYqQcx
         GCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=AKP+JWUEkEz8uNDxxoMEcy2/npy1CDFHbBjOywRncvk=;
        b=A5wzZSyaDB7jElppBfp4pdlpeB9+QIKfKk+2YVnS5TtyB7gf5kt0DSsKXMRKyPInQA
         WxVnlS3TCqKz0VJmH4+IpKZaRhlz0cqn/uaNXcsJMkg/sAwz9W//wRi0HlOx4MFf06fk
         XHYIsQLT72Rz4mnLROFRLHGxq2MK0npj3LAj6046HynnncTLIbb5nHG5aItpMiGhqwvC
         azoFfbnMaugGZKMm0+5nslfb4JZd7RIad7rDyi7tSe5mqOSfyqoOa6QlSX+dF/2woCAO
         magWztwGBGt0y38ABE2UyJWQd8NsSplJgSHdkv/CVU4wnooJqpy1AwEBmHX44L/84Yo1
         yS9A==
X-Gm-Message-State: AG10YORmGf8YhLaqUb0cPHXYlN3zWSNm6j6QtYhGvkKX0FXD3TaMzSfmN/5+oRy5/cnCNfrhmtdQ2UxrBuEvFbCB
X-Received: by 10.50.138.76 with SMTP id qo12mr13388220igb.85.1454722563048;
 Fri, 05 Feb 2016 17:36:03 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Fri, 5 Feb 2016 17:36:02 -0800 (PST)
In-Reply-To: <20160206012306.GD28749@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285664>

On Fri, Feb 5, 2016 at 5:23 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Stefan Beller wrote:
>
>> This rewrites parse_config to distinguish between configs specific to
>> one submodule and configs which apply generically to all submodules.
>> We do not have generic submodule configs yet, but the next patch will
>> introduce "submodule.fetchJobs".
>
> Does this mean that options like submodule.fetchJobs can be specified
> in either .gitmodules or .git/config, like the submodule.<name>.*
> options?

oops, yes that would work.

I was diving down the stack when looking where to put the code for
submodule.fetchJobs, and as submodule.c::submodule_config
missguided me to submodule-config.c as it told me
'anything starting with "submodule." will be parsed in the
submodule-config file', so at the time of writing that felt natural to
put it there as well.

So generalizing from there, would we expect to
have any submodule options with no section in .gitmodules?

>
> I would expect a good value for fetchJobs to be machine-specific.
> Would it work to put the submodule.fetchJobs handling in
> submodule.c::submodule_config alongside fetch.recurseModules instead?

Sure that's possible. Although I would not mind having a preset default
from a project. Would it be possible for a project to be malicious with that?

(Answer yes it can, a superproject including itself multiple times and having
parallel set to >=2 behaves similar like a fork bomb when the parallelism is
not overwritten in the actual .git/config, I would think)

>
> Thanks,
> Jonathan

Thanks,
Stefan
