From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 13/14] t4135-*.sh: Skip the "backslash" tests on cygwin
Date: Wed, 29 Dec 2010 20:56:55 +0700
Message-ID: <AANLkTiknOthWgmZxEpit9qA--54NPKq=SqPV7hv9SOPJ@mail.gmail.com>
References: <4D07B977.9010502@ramsay1.demon.co.uk> <201012142149.33725.j6t@kdbg.org>
 <4D0A94D8.6090206@ramsay1.demon.co.uk> <201012172254.31242.j6t@kdbg.org>
 <4D1100A3.2010309@ramsay1.demon.co.uk> <AANLkTi=-7ihdW_cMiAqnyjbUE_d35OFrSSnQQw4mi64G@mail.gmail.com>
 <4D1A2827.6070503@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, jrnieder@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 29 14:57:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXwWx-0005Qx-UR
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 14:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab0L2N51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 08:57:27 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52110 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab0L2N50 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 08:57:26 -0500
Received: by wwa36 with SMTP id 36so10705527wwa.1
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 05:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=oHCZndqXjuj0cX3Fqa6VY7FS4tRsX+wUXtWnwahFjNs=;
        b=TxASQ5vMtRN8RGacQAG/XyeRyJnoKeqOwHHQO62jH//d+e8IrZofz8ELfHGvur1uln
         oQ6r3KE7sXySYk7o47FU0SHd9vrcs6IdF7pNcCPQNn09w2TCZvvoXAEB5y1ofxMOUnzJ
         +dwOuEShx8WgmVMV+oXhOxIMfFMxxHOYMrnCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XkS/G33gW0psK2/PQRvA0cxLS6wdSTJ/tZ2KEhFPKuay8Re2YS8zbNw3BjURDislJd
         NMrlX4eQ82JHbUkdjaeZGwSFszsTFLU6T6s90A7CqVTDewp22I2xAeCMxWrp7u7NYKPg
         Sv239mFo90RLJUd1opgLlim2xLXREdjpfO1R0=
Received: by 10.216.52.206 with SMTP id e56mr15942249wec.19.1293631045260;
 Wed, 29 Dec 2010 05:57:25 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Wed, 29 Dec 2010 05:56:55 -0800 (PST)
In-Reply-To: <4D1A2827.6070503@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164311>

On Wed, Dec 29, 2010 at 1:10 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> Nguyen Thai Ngoc Duy wrote:
>> On Wed, Dec 22, 2010 at 2:31 AM, Ramsay Jones
>> <ramsay@ramsay1.demon.co.uk> wrote:
>>> The problem boils down to the call to strncmp_icase() suppressing the call to
>>> fnmatch() when the pattern contains glob chars, but the (remaining) string is
>>> equal to the name; thus returning an exact match (MATCHED_EXACTLY) rather than
>>> calling fnmatch (and returning either no-match or MATCHED_FNMATCH).
>>
>> I think that's expected behavior. Wildcard pathspecs are fixed
>> pathspecs will additional wildcard matching support and can match both
>> ways. See 186d604 (glossary: define pathspec)
>
> Really? Hmm, that seems ... odd! (To be clear: you are saying that an exact
> match, *even if the pattern contains glob chars*, takes precedence over the
> glob match! - again *odd*)

not exactly taking precedence. I would say it's "normal pathspecs with
extra capability", so it can match more

> Well, if you are happy with that ...

Well, we have two options here: either that, or declare it a day
(near) zero bug [1] with potentially massive impact. Personally I'd go
with which ever way that is less work :) as long as it does not annoy
me (much).

[1] Exerpt from 56fc510 ([PATCH] git-ls-files: generalized pathspecs -
2005-08-21): "the "matching" criteria is a combination of "exact path
component match" (the same as the git-diff-* family), and
"fnmatch()"." Git makes digging history fun.
-- 
Duy
