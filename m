From: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
Subject: Re: git status core dump with bad sector!
Date: Wed, 4 May 2016 16:37:25 -0400
Organization: http://www.giref.ulaval.ca
Message-ID: <572A5D85.8040203@giref.ulaval.ca>
References: <570FB06D.5060308@giref.ulaval.ca>
 <20160422051111.GA32107@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 04 22:37:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay3YI-0007bN-BV
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 22:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067AbcEDUhm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2016 16:37:42 -0400
Received: from interne.giref.ulaval.ca ([132.203.7.102]:13018 "EHLO
	mailhost.giref.ulaval.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbcEDUhl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 16:37:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 5B7D4280A5C;
	Wed,  4 May 2016 16:37:39 -0400 (EDT)
X-Virus-Scanned: amavisd-new at giref.ulaval.ca
Received: from mailhost.giref.ulaval.ca ([127.0.0.1])
	by localhost (mailhost.giref.ulaval.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z3OP7wqKLh30; Wed,  4 May 2016 16:37:25 -0400 (EDT)
Received: from [132.203.7.36] (lorien.giref.ulaval.ca [132.203.7.36])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id CC242280863;
	Wed,  4 May 2016 16:37:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <20160422051111.GA32107@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293588>

Hi,

sorry for the delay...

On 22/04/16 01:11 AM, Jeff King wrote:
> On Thu, Apr 14, 2016 at 10:59:57AM -0400, Eric Chamberland wrote:
>
>> just cloned a repo and it checked-out wihtout any error (with git 2.=
2.0) but
>> got come corrupted files (because I got some sdd failures).
>>
>> Then, I get a git core dump when trying to "git status" into the rep=
o which
>> have a "bad sector" on sdd drive (crypted partition).
>>
>> I tried with git 2.2.0 AND git version 2.8.1.185.gdc0db2c.dirty (jus=
t
>> modified the Makefile to remove STRIP part)
>>
>> In both cases, I have a  Bus error (core dumped)
>
> Interesting. There was a known issue with reading corrupted pack .idx
> files, but it was fixed in v2.8.0. So this could be a new thing.
>
> SIGBUS is somewhat rare, though (usually just accessing unmapped memo=
ry
> should get us a SIGSEGV). What platform are you on? I seem to recall
> that hardware like ARM that cares about memory alignment is more like=
ly
> to get a SIGBUS.
>
Linux ... 3.7.10-1.45-desktop #1 SMP PREEMPT Tue Dec 16 20:27:58 UTC=20
2014 (4c885a1) x86_64 x86_64 x86_64 GNU/Linux
df .
=46ilesystem                                     1K-blocks      Used=20
Available Use% Mounted on
/dev/mapper/cr_ata-ST31000524AS_6VPCXHSW-part1 961430856 699476812=20
213116108  77% /pmi

model name      : Intel(R) Xeon(R) CPU           X5690  @ 3.47GHz

>> Program received signal SIGBUS, Bus error.
>> 0x00007ffff7866d58 in ?? () from /lib64/libcrypto.so.1.0.0
>> (gdb) bt
>> #0  0x00007ffff7866d58 in ?? () from /lib64/libcrypto.so.1.0.0
>> #1  0x3334d90d8c20f3f0 in ?? ()
>> #2  0xe59b5a6cd844a601 in ?? ()
>> #3  0xc587a53f67985ae7 in ?? ()
>> #4  0x3ce81893e5541777 in ?? ()
>> #5  0xdeb18349a4b042ea in ?? ()
>> #6  0x8254de489067ec4b in ?? ()
>> #7  0x6fbef2439704c81b in ?? ()
>> #8  0xe0eee2bb385a96da in ?? ()
>> #9  0x00007ffff6e19ab3 in ?? ()
>> #10 0x00007fffffffc4d0 in ?? ()
>> #11 0x000000000000001d in ?? ()
>> #12 0x00007ffff7863f80 in SHA1_Update () from /lib64/libcrypto.so.1.=
0.0
>> #13 0x00000000005102c0 in write_sha1_file_prepare
>> (buf=3Dbuf@entry=3D0x7ffff6c81000, len=3D1673936, type=3D<optimized =
out>,
>> sha1=3Dsha1@entry=3D0x7fffffffc750 "\340_~", hdr=3Dhdr@entry=3D0x7ff=
fffffc570 "blob
>> 1673936",
>
> So I'd assume here that the problem is in accessing the memory in "bu=
f".
> to actually compute the sha1. That is mmap'd data, but the process is
> fairly bland (mmap however many bytes stat() tells us the file has, a=
nd
> then compute the sha1). You mentioned a bad sector; could it be that =
the
> filesystem is corrupted, and the OS is giving us SIGBUS when trying t=
o
> read unavailable bytes from an mmap'd file?

Yes it could be that...

>
> That would explain the SIGBUS versus SIGSEGV.
>
> What happens if you "cat" the file in question:

hmmm, it shows the beginning of the file, then ends with:

cat: Avion.Quadratique.cont.vtu.etalon: Input/output error

also, this appear in /var/log/messages:

2016-05-04T16:33:19.243595-04:00 melkor kernel: [1096660.854161]=20
ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
2016-05-04T16:33:19.243609-04:00 melkor kernel: [1096660.854165]=20
ata4.00: irq_stat 0x40000008
2016-05-04T16:33:19.243610-04:00 melkor kernel: [1096660.854168]=20
ata4.00: failed command: READ FPDMA QUEUED
2016-05-04T16:33:19.243611-04:00 melkor kernel: [1096660.854175]=20
ata4.00: cmd 60/08:00:70:30:c6/00:00:53:00:00/40 tag 0 ncq 4096 in
2016-05-04T16:33:19.243612-04:00 melkor kernel: [1096660.854175]=20
   res 41/40:08:71:30:c6/00:00:53:00:00/00 Emask 0x409 (media error) <F=
>
2016-05-04T16:33:19.243613-04:00 melkor kernel: [1096660.854178]=20
ata4.00: status: { DRDY ERR }
2016-05-04T16:33:19.243614-04:00 melkor kernel: [1096660.854180]=20
ata4.00: error: { UNC }
2016-05-04T16:33:19.340479-04:00 melkor kernel: [1096660.950794]=20
ata4.00: configured for UDMA/133
2016-05-04T16:33:19.340484-04:00 melkor kernel: [1096660.950806] sd=20
3:0:0:0: [sdb] Unhandled sense code
2016-05-04T16:33:19.340485-04:00 melkor kernel: [1096660.950809] sd=20
3:0:0:0: [sdb]
2016-05-04T16:33:19.340485-04:00 melkor kernel: [1096660.950811] Result=
:=20
hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE
2016-05-04T16:33:19.340486-04:00 melkor kernel: [1096660.950814] sd=20
3:0:0:0: [sdb]
2016-05-04T16:33:19.340486-04:00 melkor kernel: [1096660.950815] Sense=20
Key : Medium Error [current] [descriptor]
2016-05-04T16:33:19.340486-04:00 melkor kernel: [1096660.950819]=20
Descriptor sense data with sense descriptors (in hex):
2016-05-04T16:33:19.340487-04:00 melkor kernel: [1096660.950820]=20
  72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
2016-05-04T16:33:19.340487-04:00 melkor kernel: [1096660.950829]=20
  53 c6 30 71
2016-05-04T16:33:19.340488-04:00 melkor kernel: [1096660.950834] sd=20
3:0:0:0: [sdb]
2016-05-04T16:33:19.340488-04:00 melkor kernel: [1096660.950836] Add.=20
Sense: Unrecovered read error - auto reallocate failed
2016-05-04T16:33:19.340489-04:00 melkor kernel: [1096660.950839] sd=20
3:0:0:0: [sdb] CDB:
2016-05-04T16:33:19.340489-04:00 melkor kernel: [1096660.950840]=20
Read(10): 28 00 53 c6 30 70 00 00 08 00
2016-05-04T16:33:19.340489-04:00 melkor kernel: [1096660.950848]=20
end_request: I/O error, dev sdb, sector 1405497457
2016-05-04T16:33:19.340490-04:00 melkor kernel: [1096660.950870] ata4:=20
EH complete
2016-05-04T16:33:22.157550-04:00 melkor kernel: [1096663.764515]=20
ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
2016-05-04T16:33:22.157561-04:00 melkor kernel: [1096663.764519]=20
ata4.00: irq_stat 0x40000008
2016-05-04T16:33:22.157563-04:00 melkor kernel: [1096663.764522]=20
ata4.00: failed command: READ FPDMA QUEUED
2016-05-04T16:33:22.157564-04:00 melkor kernel: [1096663.764529]=20
ata4.00: cmd 60/08:00:70:30:c6/00:00:53:00:00/40 tag 0 ncq 4096 in
2016-05-04T16:33:22.157565-04:00 melkor kernel: [1096663.764529]=20
   res 41/40:08:71:30:c6/00:00:53:00:00/00 Emask 0x409 (media error) <F=
>
2016-05-04T16:33:22.157566-04:00 melkor kernel: [1096663.764532]=20
ata4.00: status: { DRDY ERR }
2016-05-04T16:33:22.157567-04:00 melkor kernel: [1096663.764534]=20
ata4.00: error: { UNC }
2016-05-04T16:33:22.180479-04:00 melkor kernel: [1096663.787215]=20
ata4.00: configured for UDMA/133
2016-05-04T16:33:22.180485-04:00 melkor kernel: [1096663.787225] sd=20
3:0:0:0: [sdb] Unhandled sense code
2016-05-04T16:33:22.180486-04:00 melkor kernel: [1096663.787228] sd=20
3:0:0:0: [sdb]
2016-05-04T16:33:22.180486-04:00 melkor kernel: [1096663.787230] Result=
:=20
hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE
2016-05-04T16:33:22.180487-04:00 melkor kernel: [1096663.787232] sd=20
3:0:0:0: [sdb]
2016-05-04T16:33:22.180487-04:00 melkor kernel: [1096663.787234] Sense=20
Key : Medium Error [current] [descriptor]
2016-05-04T16:33:22.180487-04:00 melkor kernel: [1096663.787237]=20
Descriptor sense data with sense descriptors (in hex):
2016-05-04T16:33:22.180488-04:00 melkor kernel: [1096663.787238]=20
  72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
2016-05-04T16:33:22.180488-04:00 melkor kernel: [1096663.787247]=20
  53 c6 30 71
2016-05-04T16:33:22.180489-04:00 melkor kernel: [1096663.787252] sd=20
3:0:0:0: [sdb]
2016-05-04T16:33:22.180489-04:00 melkor kernel: [1096663.787254] Add.=20
Sense: Unrecovered read error - auto reallocate failed
2016-05-04T16:33:22.180490-04:00 melkor kernel: [1096663.787256] sd=20
3:0:0:0: [sdb] CDB:
2016-05-04T16:33:22.180490-04:00 melkor kernel: [1096663.787258]=20
Read(10): 28 00 53 c6 30 70 00 00 08 00
2016-05-04T16:33:22.180490-04:00 melkor kernel: [1096663.787266]=20
end_request: I/O error, dev sdb, sector 1405497457
2016-05-04T16:33:22.180491-04:00 melkor kernel: [1096663.787280] ata4:=20
EH complete


>
>> #15 0x00000000005159f8 in index_mem (sha1=3Dsha1@entry=3D0x7fffffffc=
750
>> "\340_~", buf=3Dbuf@entry=3D0x7ffff6c81000, size=3D1673936,
>> type=3Dtype@entry=3DOBJ_BLOB,
>>      path=3Dpath@entry=3D0x80a818 "Ressources/dev/Test.ExportationVT=
K/Ressources.Avion/Avion.Quadratique.cont.vtu.etalon",
>> flags=3Dflags@entry=3D0) at sha1_file.c:3305
>
> Can it show all of the bytes? I guess from the "size" field it's too =
big
> to manually verify, but "cat >/dev/null" should be enough to see if w=
e
> can read the whole thing.
>
>> Ii would have expected git to first gave me an error when checking o=
ut the
>> files!!! Here is the log:
>>
>> Checking out files:  99% (28645/28934)
>> Checking out files: 100% (28934/28934)
>> Checking out files: 100% (28934/28934), done.
>> Already on 'master'
>> Your branch is up-to-date with 'origin/master'.
>>      On valide le d=C3=A9p=C3=B4t TestValidation avec la r=C3=A9f=C3=
=A9rence:
>> 9b4a485202b2b52922377842c15bfd605d240667
>> HEAD is now at 9b4a485 BUG: On sp=C3=A9cifie bash comme shell...
>>
>> But at least 1 file is corrupted!
>>
>> I keep preciously this faulty repo to further investigation with som=
eone who
>> can help dig into the coredump and correct it...
>
> So _if_ my guess is right that you have filesystem corruption, git ma=
y
> not even know about it. It wrote the file, and the OS said "OK,
> success", not knowing it had been partially corrupted.

ok, I see...
>
> And if that guess is right, it also means there's no git bug to fix.
> SIGBUS is the natural way for the OS to tell the process that mmap'd
> data isn't available.

doh... then forget about this...

Thanks for the enlightments! :)

Eric
>
> -Peff
>
