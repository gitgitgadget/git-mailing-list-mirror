From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 13:19:04 -0700
Message-ID: <4DB9CBB8.8050605@zytor.com>
References: <20110427225114.GA16765@elte.hu> <7voc3r5kzn.fsf@alter.siamese.dyndns.org> <20110428003541.GA18382@linux-mips.org> <20110428081817.GA29344@pcpool00.mathematik.uni-freiburg.de> <4DB9367B.2050607@op5.se> <BANLkTikU3evfo86WmQeVS_Z41s3xSK1DJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	"Bernhard R. Link" 
	<brl+ccmadness@pcpool00.mathematik.uni-freiburg.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_?= =?ISO-8859-1?Q?Weisbecker?= 
	<fweisbec@gmail.com>, Pekka Enberg <penberg@cs.helsinki.fi>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Apr 28 22:22:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFXjB-0000ql-Fb
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 22:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933487Ab1D1UWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 16:22:17 -0400
Received: from terminus.zytor.com ([198.137.202.10]:44156 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932892Ab1D1UWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 16:22:16 -0400
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by mail.zytor.com (8.14.4/8.14.3) with ESMTP id p3SKJ4DN008883
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 28 Apr 2011 13:19:05 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Thunderbird/3.1.9
In-Reply-To: <BANLkTikU3evfo86WmQeVS_Z41s3xSK1DJw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172401>

On 04/28/2011 02:55 AM, Erik Faye-Lund wrote:
> 
> I disagree. We have no guarantee that the SHA-1s are aligned on x86
> either, and unaligned accesses are slow on x86.
> 

Not particularly, especially not statistically.  Furthermore, for a
sizable chunk like a SHA-1, not all accesses will have the cross-grain
penalities that you sometimes can have.

> I think it's much much cleaner to add an early-out on the first byte,
> and hope that memcmp is optimized properly. If it's not, those
> platforms can add an override to memcmp in git-compat-util and/or
> compat/*.

Overall, doing an architecture optimization library especially for
widely used architectures like x86 is not a bad idea.

	-hpa
