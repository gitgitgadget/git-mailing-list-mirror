From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: Using pickaxe to track changed symbol CR4_FEATURES_ADDR
Date: Mon, 5 Jun 2006 13:11:51 -0700
Organization: YPO4
Message-ID: <20060605131151.b8878c7c.rdunlap@xenotime.net>
References: <20060605102627.GB24346@cip.informatik.uni-erlangen.de>
	<7v8xob4bft.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: sithglan@stud.uni-erlangen.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 22:09:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnLOD-0003Rq-Uj
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 22:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWFEUJI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 16:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWFEUJI
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 16:09:08 -0400
Received: from xenotime.net ([66.160.160.81]:43997 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751403AbWFEUJH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jun 2006 16:09:07 -0400
Received: from midway.site ([71.245.102.105]) by xenotime.net for <git@vger.kernel.org>; Mon, 5 Jun 2006 13:09:02 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xob4bft.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21337>

On Mon, 05 Jun 2006 13:03:34 -0700 Junio C Hamano wrote:

> Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:
> 
> > I am looking for the symbol CR4_FEATURES_ADDR which must be gone in one
> > of the last kernel revision. Now how I do use pickaxe to track any
> > changes that involve my missing symbol? Or is there a better way to
> > track that change down?
> 
> None of the major recent versions seem to have the symbol.
> 
> 	: gitster; git grep -e CR4_FEATURES_ADDR \
>         	v2.6.12-rc2 v2.6.12 v2.6.13 v2.6.14 v2.6.15 \
>         	v2.6.16
> 
> and I did not get any google hits for "CR4_FEATURES_ADDR".  Are
> you spelling it right?

include/asm-i386/processor.h has names like:

/*
 * Intel CPU features in CR4
 */
#define X86_CR4_VME		0x0001	/* enable vm86 extensions */
#define X86_CR4_PVI		0x0002	/* virtual interrupts flag enable */
#define X86_CR4_TSD		0x0004	/* disable time stamp at ipl 3 */
#define X86_CR4_DE		0x0008	/* enable debugging extensions */
#define X86_CR4_PSE		0x0010	/* enable page size extensions */
#define X86_CR4_PAE		0x0020	/* enable physical address extensions */
#define X86_CR4_MCE		0x0040	/* Machine check enable */
#define X86_CR4_PGE		0x0080	/* enable global pages */
#define X86_CR4_PCE		0x0100	/* enable performance counters at ipl 3 */
#define X86_CR4_OSFXSR		0x0200	/* enable fast FPU save and restore */
#define X86_CR4_OSXMMEXCPT	0x0400	/* enable unmasked SSE exceptions */

extern unsigned long mmu_cr4_features;

static inline void set_in_cr4 (unsigned long mask)
{
	unsigned cr4;
	mmu_cr4_features |= mask;
	cr4 = read_cr4();
	cr4 |= mask;
	write_cr4(cr4);
}

static inline void clear_in_cr4 (unsigned long mask)
{
	unsigned cr4;
	mmu_cr4_features &= ~mask;
	cr4 = read_cr4();
	cr4 &= ~mask;
	write_cr4(cr4);
}


but nothing exactly like you asked about.

---
~Randy
