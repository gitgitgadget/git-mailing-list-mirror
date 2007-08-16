From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Thu, 16 Aug 2007 08:04:48 +0200
Message-ID: <3CDBDF39-F6FB-411D-9691-3146B882B8EC@zib.de>
References: <76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de> <e7bda7770708101531n782118e9qb9c6de4e934940ea@mail.gmail.com> <EF7DFA5A-9C3A-4D0B-9533-D1D60AE4A44C@zib.de> <e7bda7770708141704m587dfdbdqfbab51b8ac6fcff@mail.gmail.com> <30FE2B1C-B651-4F1D-B5D9-CD3C3261F531@zib.de> <85fy2l1i1g.fsf@lola.goethe.zz> <ABA1D7D2-92A6-4E8C-AC36-93912621E3D4@zib.de> <86k5rx474o.fsf@lola.quinscape.zz> <20070815073811.GL27913@spearce.org> <30e4a070708150542m3f3f5c62l5e4bf5b3ff098b52@mail.gmail.com> <30e4a070708150548r3234cd66yd4ee6a85989a98b1@mail.gmail.com> <3F9AF722-0610-4778-A244-DBE5A0918D0B@zib.de> <46C39A06.7020003@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Kastrup <dak@gnu.org>,
	Torgil Svensson <torgil.svensson@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 08:05:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILYTa-0005YS-SV
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 08:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963AbXHPGEz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 02:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754428AbXHPGEz
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 02:04:55 -0400
Received: from mailer.zib.de ([130.73.108.11]:37464 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754451AbXHPGEy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 02:04:54 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7G645g3017108;
	Thu, 16 Aug 2007 08:04:40 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db107b4.pool.einsundeins.de [77.177.7.180])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7G643cI023826
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 16 Aug 2007 08:04:04 +0200 (MEST)
In-Reply-To: <46C39A06.7020003@gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55979>


On Aug 16, 2007, at 2:27 AM, Mark Levedahl wrote:

> Steffen Prohaska wrote:
>>
>> If reg.exe is not there kdiff3 will not be found. The code will
>> already be _ignored_. It's just not working.
> I'm really thinking forward to when you try to reintegrate this  
> into git.git: Platform specific code needs to be wrapped with a  
> test that has a known result on all platforms.

I thought about that, too.

The code works on _all_ platforms as follows:
- if 'REG' is available, its output is parsed for the diffcommand;
- if 'REG' is not available the code is ignored.

The only problem I see with this approach is that the code does not
test if 'REG' was present and returned an error for an unknown reason.
btw, in merge tool we would probably ignore such an error anyway.


What does 'platform specific' mean? Is MINGW the platform? If so,
how about Cygwin? Or is Windows the platform?

Windows will often be the right choice.

So how do we test for Windows?

On my machine uname returns the following in Cygwin and Mingw
- CYGWIN_NT-5.1
- MINGW32_NT-5.1


The patch I sent does not test for platforms, but assumes that 'REG'
will only be available on Windows. Errors will just be ignored, which
is is not perfect. This could be improved by testing first if 'REG' is
available and if so report errors returned by REG.

Assuming that 'REG' is only available on Windows and has a defined
meaning seems to be reasonable assumption to me. I don't see the need
to test which platform the script is running on. Testing if 'REG' is
available seems to be sufficient.

	Steffen
