From: David Kastrup <dak@gnu.org>
Subject: Re: bug? git push triggers auto pack when gc.auto = 0
Date: Tue, 04 Feb 2014 09:22:27 +0100
Organization: Organization?!?
Message-ID: <87r47jxp6k.fsf@fencepost.gnu.org>
References: <loom.20140204T030158-758@post.gmane.org>
	<CACsJy8Bo4XgA-g2hy+_pVEKLnerL9WNhpWe==zJANmCMdGXuow@mail.gmail.com>
	<loom.20140204T055040-646@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 09:22:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAbHH-0003hg-HL
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 09:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbaBDIWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 03:22:40 -0500
Received: from plane.gmane.org ([80.91.229.3]:60965 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576AbaBDIWi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 03:22:38 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WAbHB-0003fe-3a
	for git@vger.kernel.org; Tue, 04 Feb 2014 09:22:37 +0100
Received: from x2f46198.dyn.telefonica.de ([2.244.97.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 09:22:37 +0100
Received: from dak by x2f46198.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 09:22:37 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f46198.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:fPbbGVdCtoTDsn8CM/sN4Dpgx1E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241516>

chris <jugg@hotmail.com> writes:

> Duy Nguyen <pclouds <at> gmail.com> writes:
>> On Tue, Feb 4, 2014 at 9:20 AM, chris <jugg <at> hotmail.com> wrote:
>> > $ git push origin next
>> > Counting objects: 56, done.
>> > Delta compression using up to 4 threads.
>> > Compressing objects: 100% (9/9), done.
>> > Writing objects: 100% (9/9), 895 bytes | 0 bytes/s, done.
>> > Total 9 (delta 8), reused 0 (delta 0)
>> > Auto packing the repository for optimum performance.

> However, I question why I should even care about this message?  I'm going to
> assume that simply it is a lengthy synchronous operation that someone felt
> deserved some verbosity to why the client push action is taking longer than
> it should.  Yet that makes me question why I'm being penalized for this
> server side operation.  My client time should not be consumed for server
> side house keeping.

Your "client time" is not consumed: this is not a busy wait.  Git server
processes are synchronous: they are initiated and completed under the
control of a client.  That means that if you run a batch script
executing a number of commands in a client, it will not saturate the
server with half-finished processes and/or will refuse to honor requests
because the repository is locked.

> An obvious fix is to disable gc on the server and implement a cron job
> for the house keeping task.  However, as often the case one does not
> have control over the server, so it is unfortunate that git has this
> server side house keeping as a blocking operation to a client action.

_Any_ git operation is "blocking" the respective initiating client.

>> > So my question is, should gc.auto = 0 disable auto-packing from occurring on
>> > git push and other non-gc commands?
>> 
>> Yes it should.
>
> Thanks for the confirmation.

And indeed, there is no autopacking occuring on your site when doing git
push.  The server administrator will be rather glad that the clients'
configuration variables don't affect his server's operation.

-- 
David Kastrup
