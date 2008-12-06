From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFCv3 1/2] gitweb: add patch view
Date: Sat, 6 Dec 2008 14:01:09 +0100
Message-ID: <cb7bb73a0812060501s6a3faea7l74e81c2a591ba2a7@mail.gmail.com>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1228345188-15125-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <200812060134.22959.jnareb@gmail.com>
	 <7vabbaxh8y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 14:02:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8wnm-0006Dy-H1
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 14:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbYLFNBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 08:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbYLFNBM
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 08:01:12 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:7620 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbYLFNBL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 08:01:11 -0500
Received: by ey-out-2122.google.com with SMTP id 6so168972eyi.37
        for <git@vger.kernel.org>; Sat, 06 Dec 2008 05:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1GOg3mwZ/pCdklZFd32c3yJJeQ1+ewX3S+FSvqp7SHE=;
        b=KxKkZYFa2/zYbCw+FSYO/ogqcdkdD90zI5pEXM62iPH8THPx6iuWAgOPFIifpK4UBI
         uhwsfU9v+aOIMmqY7bw+813zdNAEFF0jAppw7eLGN2j5EiKC35iFW6l+5AsetQS6FIgW
         cKrplQlLkzbTEyqKIb+zs8+vNYIg9zeAoSliM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Q4b13j+V3x5DpPYEvLhMiHq1tRYMro5lEpHjWz6Ku3gygUB1tUHqCbiWsgP8lDvKFx
         D82SAGwFI7rN1QsKG3bYvQMrEFEmgAmFOQFN3z/3X5e2BI5Bu1VJH2Nd6JEZks06QjnI
         5Ix0UuRt8q624l/lpVxGcvvs20l7c6gv8Gsz0=
Received: by 10.210.27.20 with SMTP id a20mr1200499eba.137.1228568469139;
        Sat, 06 Dec 2008 05:01:09 -0800 (PST)
Received: by 10.210.79.12 with HTTP; Sat, 6 Dec 2008 05:01:09 -0800 (PST)
In-Reply-To: <7vabbaxh8y.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102452>

On Sat, Dec 6, 2008 at 1:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>>> +    # The maximum number of patches in a patchset generated in patch
>>> +    # view. Set this to 0 or undef to disable patch view, or to a
>>> +    # negative number to remove any limit.
>>> +    'patches' => {
>>> +            'override' => 1,
>>> +            'default' => [16]},
>>>  );
>>
>> You need to set "'sub' => \&feature_patches" for feature to be
>> override-able at all.  Also features are usually not overridable
>> by default, which reduces load a tiny bit (by _possibly_ not reading
>> config, although that shouldn't matter much now with reading whole
>> commit using single call to git-config, and not one call per variable).
>> And I think the default might be set larger: 'log' view generates
>> as big if not bigger load, and it is split into 100 commits long
>> pages.
>
> I do not think defaulting to 'no' for overridability nor defaulting a new
> feature to 'disabled' have much to do with the load, but they are more
> about the principle of least surprise.  Somebody who runs gitweb in the
> playpen he was given on the server shouldn't be getting a phone call from
> his users late at night complaining that the page his gitweb serves look
> different and has one extra link per each line, only because the sysadmin
> of the server decided to update git to 1.6.1 without telling him.
>
> Once a new version capable of serving a new feature is introduced, he can
> plan, announce and deploy by switching the feature on in his gitweb
> configuration file.
>
> Some things, like sitewide default css changes, cannot be made disabled
> by default.  But a new feature can easily be kept disabled by default not
> to cause needless surprises.

In the eternal war between making feature easily available and not
disturbing the user too much between upgrades, I'm more on the 'making
available' field, especially when the features are not particularly
invasive (e.g., the patch view only adds one single link, on the
navigation bar, and only in some views).

It should also be noted that if the sysadmin deploys a new software
version without telling its users, there's an obvious communication
problem between the sysadmin and its users, but that's not something
the tool developers should try to work around. Otherwise we'd still be
offering the dash version of the commands by default.

(Plus, weren't you the one suggesting that the remote heads feature
should be enabled by default? And that's an even more invasive change,
if you ask me.)


-- 
Giuseppe "Oblomov" Bilotta
