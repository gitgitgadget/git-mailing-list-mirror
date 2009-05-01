From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: Why Git is so fast
Date: Thu, 30 Apr 2009 17:23:57 -0700
Message-ID: <f488382f0904301723i37ef03d9w4e93848e603ed28b@mail.gmail.com>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>
	 <m3fxfqnxn5.fsf_-_@localhost.localdomain>
	 <b4087cc50904300556s359c91dfu444fa40ea85bd66e@mail.gmail.com>
	 <200904301728.06989.jnareb@gmail.com>
	 <20090430185244.GR23604@spearce.org> <86iqkllw0c.fsf@broadpark.no>
	 <20090430204033.GV23604@spearce.org> <8663gllt88.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Fri May 01 02:24:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzgYL-0000lJ-9O
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 02:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763499AbZEAAYF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Apr 2009 20:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbZEAAYC
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 20:24:02 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:55812 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758629AbZEAAX7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2009 20:23:59 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1239624yxj.1
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 17:23:57 -0700 (PDT)
Received: by 10.90.115.17 with SMTP id n17mr657169agc.104.1241137437362; Thu, 
	30 Apr 2009 17:23:57 -0700 (PDT)
In-Reply-To: <8663gllt88.fsf@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118053>

On Thu, Apr 30, 2009 at 2:36 PM, Kjetil Barvik <barvik@broadpark.no> wr=
ote:
> * "Shawn O. Pearce" <spearce@spearce.org> writes:
> |> =A0 =A0 =A04) The "static inline void hashcpy(....)" in cache.h co=
uld then
> |> =A0 =A0 =A0 =A0 maybe be written like this:
> |
> | Its already done as "memcpy(a, b, 20)" which most compilers will
> | inline and probably reduce to 5 word moves anyway. =A0That's why
> | hashcpy() itself is inline.
>
> =A0But would the compiler be able to trust that the hashcpy() is alwa=
ys
> =A0called with correct word alignment on variables a and b?
>
> =A0I made a test and compiled git with:
>
> =A0 =A0make USE_NSEC=3D1 CFLAGS=3D"-march=3Dcore2 -mtune=3Dcore2 -O2 =
-g2 -fno-stack-protector" clean all
>
> =A0compiler: gcc (Gentoo 4.3.3-r2 p1.1, pie-10.1.5) 4.3.3
> =A0CPU: Intel(R) Core(TM)2 CPU T7200 @ 2.00GHz GenuineIntel
>
> =A0Then used gdb to get the following:
>
> (gdb) disassemble write_sha1_file
> Dump of assembler code for function write_sha1_file:
> 0x080e3830 <write_sha1_file+0>: push =A0 %ebp
> 0x080e3831 <write_sha1_file+1>: mov =A0 =A0%esp,%ebp
> 0x080e3833 <write_sha1_file+3>: sub =A0 =A0$0x58,%esp
> 0x080e3836 <write_sha1_file+6>: lea =A0 =A0-0x10(%ebp),%eax
> 0x080e3839 <write_sha1_file+9>: mov =A0 =A0%ebx,-0xc(%ebp)
> 0x080e383c <write_sha1_file+12>: =A0 =A0 =A0 =A0mov =A0 =A0%esi,-0x8(=
%ebp)
> 0x080e383f <write_sha1_file+15>: =A0 =A0 =A0 =A0mov =A0 =A0%edi,-0x4(=
%ebp)
> 0x080e3842 <write_sha1_file+18>: =A0 =A0 =A0 =A0mov =A0 =A00x14(%ebp)=
,%ebx
> 0x080e3845 <write_sha1_file+21>: =A0 =A0 =A0 =A0mov =A0 =A0%eax,0x8(%=
esp)
> 0x080e3849 <write_sha1_file+25>: =A0 =A0 =A0 =A0lea =A0 =A0-0x44(%ebp=
),%edi
> 0x080e384c <write_sha1_file+28>: =A0 =A0 =A0 =A0lea =A0 =A0-0x24(%ebp=
),%esi
> 0x080e384f <write_sha1_file+31>: =A0 =A0 =A0 =A0mov =A0 =A0%edi,0x4(%=
esp)
> 0x080e3853 <write_sha1_file+35>: =A0 =A0 =A0 =A0mov =A0 =A0%esi,(%esp=
)
> 0x080e3856 <write_sha1_file+38>: =A0 =A0 =A0 =A0mov =A0 =A00x10(%ebp)=
,%ecx
> 0x080e3859 <write_sha1_file+41>: =A0 =A0 =A0 =A0mov =A0 =A00xc(%ebp),=
%edx
> 0x080e385c <write_sha1_file+44>: =A0 =A0 =A0 =A0mov =A0 =A00x8(%ebp),=
%eax
> 0x080e385f <write_sha1_file+47>: =A0 =A0 =A0 =A0call =A0 0x80e0350 <w=
rite_sha1_file_prepare>
> 0x080e3864 <write_sha1_file+52>: =A0 =A0 =A0 =A0test =A0 %ebx,%ebx
> 0x080e3866 <write_sha1_file+54>: =A0 =A0 =A0 =A0je =A0 =A0 0x80e3885 =
<write_sha1_file+85>
>
> 0x080e3868 <write_sha1_file+56>: =A0 =A0 =A0 =A0mov =A0 =A0-0x24(%ebp=
),%eax
> 0x080e386b <write_sha1_file+59>: =A0 =A0 =A0 =A0mov =A0 =A0%eax,(%ebx=
)
> 0x080e386d <write_sha1_file+61>: =A0 =A0 =A0 =A0mov =A0 =A0-0x20(%ebp=
),%eax
> 0x080e3870 <write_sha1_file+64>: =A0 =A0 =A0 =A0mov =A0 =A0%eax,0x4(%=
ebx)
> 0x080e3873 <write_sha1_file+67>: =A0 =A0 =A0 =A0mov =A0 =A0-0x1c(%ebp=
),%eax
> 0x080e3876 <write_sha1_file+70>: =A0 =A0 =A0 =A0mov =A0 =A0%eax,0x8(%=
ebx)
> 0x080e3879 <write_sha1_file+73>: =A0 =A0 =A0 =A0mov =A0 =A0-0x18(%ebp=
),%eax
> 0x080e387c <write_sha1_file+76>: =A0 =A0 =A0 =A0mov =A0 =A0%eax,0xc(%=
ebx)
> 0x080e387f <write_sha1_file+79>: =A0 =A0 =A0 =A0mov =A0 =A0-0x14(%ebp=
),%eax
> 0x080e3882 <write_sha1_file+82>: =A0 =A0 =A0 =A0mov =A0 =A0%eax,0x10(=
%ebx)
>
> =A0I admit that I am not particular familar with intel machine
> =A0instructions, but I guess that the above 10 mov instructions is th=
e
> =A0result for the compiled inline hashcpy() in the write_sha1_file()
> =A0function in sha1_file.c
>
> =A0Question: would it be possible for the compiler to compile it down=
 to
> =A0just 5 mov instructions if we had used unsigned 32 bits type? =A0O=
r is
> =A0this the best we can reasonable hope for inside the write_sha1_fil=
e()
> =A0function?
>
> =A0I checked 3 other output of "disassemble function_foo", and it see=
ms
> =A0that those 3 functions I checked got 10 mov instructions for the
> =A0inline hashcpy(), as far as I can tell.
>
> 0x080e3885 <write_sha1_file+85>: =A0 =A0 =A0 =A0mov =A0 =A0%esi,(%esp=
)
> 0x080e3888 <write_sha1_file+88>: =A0 =A0 =A0 =A0call =A0 0x80e3800 <h=
as_sha1_file>
> 0x080e388d <write_sha1_file+93>: =A0 =A0 =A0 =A0xor =A0 =A0%edx,%edx
> 0x080e388f <write_sha1_file+95>: =A0 =A0 =A0 =A0test =A0 %eax,%eax
> 0x080e3891 <write_sha1_file+97>: =A0 =A0 =A0 =A0jne =A0 =A00x80e38b6 =
<write_sha1_file+134>
> 0x080e3893 <write_sha1_file+99>: =A0 =A0 =A0 =A0mov =A0 =A00xc(%ebp),=
%eax
> 0x080e3896 <write_sha1_file+102>: =A0 =A0 =A0 mov =A0 =A0%edi,%edx
> 0x080e3898 <write_sha1_file+104>: =A0 =A0 =A0 mov =A0 =A0%eax,0x4(%es=
p)
> 0x080e389c <write_sha1_file+108>: =A0 =A0 =A0 mov =A0 =A0-0x10(%ebp),=
%ecx
> 0x080e389f <write_sha1_file+111>: =A0 =A0 =A0 mov =A0 =A00x8(%ebp),%e=
ax
> 0x080e38a2 <write_sha1_file+114>: =A0 =A0 =A0 movl =A0 $0x0,0x8(%esp)
> 0x080e38aa <write_sha1_file+122>: =A0 =A0 =A0 mov =A0 =A0%eax,(%esp)
> 0x080e38ad <write_sha1_file+125>: =A0 =A0 =A0 mov =A0 =A0%esi,%eax
> 0x080e38af <write_sha1_file+127>: =A0 =A0 =A0 call =A0 0x80e1e40 <wri=
te_loose_object>
> 0x080e38b4 <write_sha1_file+132>: =A0 =A0 =A0 mov =A0 =A0%eax,%edx
> 0x080e38b6 <write_sha1_file+134>: =A0 =A0 =A0 mov =A0 =A0%edx,%eax
> 0x080e38b8 <write_sha1_file+136>: =A0 =A0 =A0 mov =A0 =A0-0xc(%ebp),%=
ebx
> 0x080e38bb <write_sha1_file+139>: =A0 =A0 =A0 mov =A0 =A0-0x8(%ebp),%=
esi
> 0x080e38be <write_sha1_file+142>: =A0 =A0 =A0 mov =A0 =A0-0x4(%ebp),%=
edi
> 0x080e38c1 <write_sha1_file+145>: =A0 =A0 =A0 leave
> 0x080e38c2 <write_sha1_file+146>: =A0 =A0 =A0 ret
> End of assembler dump.
> (gdb)
>
> =A0So, maybe the compiler is doing the right thing after all?
>

Well, I just tested this with GCC myself. I used this segment of code:

        #include <memory.h>
        void hashcpy(unsigned char *sha_dst, const unsigned char *sha_s=
rc)
        {
                memcpy(sha_dst, sha_src, 20);
        }

I compiled using Apple's GCC 4.0.1 (note that GCC 4.3 and 4.4 vanilla
yield the same code) with these parameters to get Intel assembly:
        gcc -O2 -arch i386 -march=3Dpentium3 -mtune=3Dpentium3
-fomit-frame-pointer -fno-strict-aliasing -S test.c
and these parameters to get the equivalent PowerPC code:
        gcc -O2 -mcpu=3DG5 -arch ppc -fomit-frame-pointer
-fno-strict-aliasing -S test.c

Intel code:
        .text
        .align 4,0x90
=2Eglobl _hashcpy
_hashcpy:
        subl    $12, %esp
        movl    20(%esp), %edx
        movl    16(%esp), %ecx
        movl    (%edx), %eax
        movl    %eax, (%ecx)
        movl    4(%edx), %eax
        movl    %eax, 4(%ecx)
        movl    8(%edx), %eax
        movl    %eax, 8(%ecx)
        movl    12(%edx), %eax
        movl    %eax, 12(%ecx)
        movl    16(%edx), %eax
        movl    %eax, 16(%ecx)
        addl    $12, %esp
        ret
        .subsections_via_symbols


and the PowerPC code:

        .section __TEXT,__text,regular,pure_instructions
        .section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions=
,32
        .machine ppc970
        .text
        .align 2
        .p2align 4,,15
        .globl _hashcpy
_hashcpy:
        lwz r0,0(r4)
        lwz r2,4(r4)
        lwz r9,8(r4)
        lwz r11,12(r4)
        stw r0,0(r3)
        stw r2,4(r3)
        stw r9,8(r3)
        stw r11,12(r3)
        lwz r0,16(r4)
        stw r0,16(r3)
        blr
        .subsections_via_symbols


So it does look like GCC does what it should and it inlines the memcpy.

A bit off topic, but the results are rather interesting to me, and I
think I see a weakness in how GCC is doing this on Intel. Someone
please correct me if I'm wrong, but the PowerPC code seems much better
because it can yield very high instruction-level parallelism. It does
5 loads and then 5 stores, using 4 registers for temporary storage and
2 registers for pointers.

I realize the Intel x86 architecture is quite constrained in that it
has so few general purpose registers, but there has to be better code
than what GCC emitted above. It seems like the processor would stall
because of the quantity of sequential inter-dependent instructions
that can't be done in parallel (mov to memory that depends on a mov to
eax, etc).

I suppose the code might not be stalling if it's using the maximum
number of registers and doing as many memory accesses that it can per
clock, but based on known details about the architecture, does it seem
to be doing that?

- Steven
