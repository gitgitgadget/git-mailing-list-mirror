From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Problems with unrecognized headers in git bundles
Date: Thu, 23 Feb 2012 14:27:18 +0100
Message-ID: <CABPQNSZyNTnXOO=YxUfEQKv3UbiuufWvi9-3ZvdOAqwQ=aAj+w@mail.gmail.com>
References: <4F451259.7010304@codethink.co.uk> <CAA787rm4c1zYgQJ3kP5=ujpEK1Dda9+h_P3BBmg2yX2eZca=TA@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?=D8yvind_A=2E_Holm?= <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Thu Feb 23 14:28:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0YiK-0005t9-Ad
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 14:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023Ab2BWN17 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 08:27:59 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39926 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab2BWN16 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2012 08:27:58 -0500
Received: by pbcun15 with SMTP id un15so1420150pbc.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 05:27:58 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 10.68.73.225 as permitted sender) client-ip=10.68.73.225;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of kusmabite@gmail.com designates 10.68.73.225 as permitted sender) smtp.mail=kusmabite@gmail.com; dkim=pass header.i=kusmabite@gmail.com
Received: from mr.google.com ([10.68.73.225])
        by 10.68.73.225 with SMTP id o1mr4116941pbv.77.1330003678276 (num_hops = 1);
        Thu, 23 Feb 2012 05:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=fcO2xz1NEkyRWtFrQYFepmFo2tnw/QEcXuql5+5cum4=;
        b=lpR1h/cNVZYC/sohm5D3gyZxO9cZ6ENd1saBAZSyc4gSmQSNdYqYP1Diea4PsH811d
         plq7KtKANTY0wJ90MB9jFtvYh0uRkvd/19VW24Z1jzS5t8CInUF24QOvGQON8eb+NGx8
         cQBmC1IED1ymmENwFmW2J87hGEeJlaEwVTc9g=
Received: by 10.68.73.225 with SMTP id o1mr3501091pbv.77.1330003678210; Thu,
 23 Feb 2012 05:27:58 -0800 (PST)
Received: by 10.68.12.194 with HTTP; Thu, 23 Feb 2012 05:27:18 -0800 (PST)
In-Reply-To: <CAA787rm4c1zYgQJ3kP5=ujpEK1Dda9+h_P3BBmg2yX2eZca=TA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191363>

On Wed, Feb 22, 2012 at 9:25 PM, =D8yvind A. Holm <sunny@sunbase.org> w=
rote:
> On 22 February 2012 17:05, Jannis Pohlmann wrote:
>> Hi,
>>
>> creating bundles from some repositories seems to lead to bundles wit=
h
>> incorrectly formatted headers, at least with git >=3D 1.7.2. When
>> cloning from such bundles, git prints the following error/warning:
>>
>> =A0$ git clone perl-clone.bundle perl-clone
>> =A0Cloning into 'perl-clone'...
>> =A0warning: unrecognized header: --work around mangled archname on..=
=2E
>>
>> This can be reproduced easily with git from any version >=3D 1.7.2 o=
r
>> from master, using the following steps:
>>
>> =A0git clone git://perl5.git.perl.org/perl.git perl
>> =A0GIT_DIR=3Dperl/.git git bundle create perl-clone.bundle --all
>> =A0git clone perl-clone.bundle perl-clone
>>
>> The content of the bundle is:
>>
>> =A0# v2 git bundle
>> =A0-- work around mangled archname on win32 while finding...
>> =A039ec54a59ce332fc44e553f4e5eeceef88e8369e refs/heads/blead
>> =A039ec54a59ce332fc44e553f4e5eeceef88e8369e refs/remotes/origin/HEAD
>
> Have researched this a bit, and I've found that all git versions back=
 to
> when git-bundle was introduced (around v1.5.4) produces the same inva=
lid
> line. The culprit is commit 3e8148feadabd0d0b1869fcc4d218a6475a5b0bc =
in
> perl.git, branch 'maint-5.005'. The log message of that commit contai=
ns
> email headers, maybe that's the reason git bundle gets confused?

=46or the lazy, the commit can be found here:

http://perl5.git.perl.org/perl.git/commit/3e8148feadabd0d0b1869fcc4d218=
a6475a5b0bc
