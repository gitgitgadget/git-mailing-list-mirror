From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/2] run-parallel: rename set_nonblocking to
 set_nonblocking_or_die
Date: Thu, 5 Nov 2015 07:07:37 +0100
Message-ID: <563AF229.1060302@web.de>
References: <563A63BA.9020407@web.de>
 <1446677029-10745-1-git-send-email-sbeller@google.com>
 <1446677029-10745-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de, j6t@kdbg.org, gitster@pobox.com,
	git@vger.kernel.org, johannes.schindelin@gmx.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 07:07:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuDhO-00028C-1c
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 07:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174AbbKEGG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 01:06:57 -0500
Received: from mout.web.de ([212.227.17.12]:61845 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726AbbKEGG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 01:06:56 -0500
Received: from [192.168.88.158] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0ML8Kj-1ZuUfv310L-000KOJ; Thu, 05 Nov 2015 07:06:38
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <1446677029-10745-2-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:T5sUxcDbvdCdA3n18s/eewJYqGDG1uqei7ibBenMv1buXBEROAf
 igs/sVNqvUdedpeq6IGNGZHH53cDfxc3C/sNDjfR53xaW5oxKBLBg6rC7CuQ5tKdf2pIaSW
 l8uYl4ROvinxfK10tDDH8ganhXL/B9bvr0AbML0ylm+qhJdYhID3iJiJCu7/FM87mkRB9X+
 cSwxj0bQlvZc3+v+eh2tg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6brterVjvO0=:v50ZGvtoY2YtAOh6njMMqw
 gUocYKubIO9qreyhIyw2leTpWgCfrYZSH38dxXrzB/OtuPEdUSp9rsjMQLqOWo5Z2e+XntuD8
 mwF3C0SrTTuOfTg3VC17h568WSdgEHJU+PX7cDeHOuUgLIyiyJD+ztHC03h4rm1CymKqijjhl
 X1SkowMEXnrBjKjyort/5prje314Usyj4zy9CMb2phtvjLBrW4tlHDKFNaxxRl9eShtu10WMF
 EWLoa+2+KUdPTV1iSXysLnLPr2tiHFjcg+sHyeOtsSwLcTYdj0w9BoR3gTUW/b3Z8U+Imu9Ih
 l2H3KEET6bqc1WdZXMNMTfpgObj8dKuS8iO2OnzCTavNzFktKe4Z7bARW7Pn/MhHPBbcJWxT5
 5UlhWwD8Zgn+zscWLZbZM9rWxq1VcwxlmfTXNWcu3Tmkz8OggqudsMGQ26E5NFPQD3RHxDsiF
 ZqPMbsqPQZzguc+xm9PIB3qDw+/3fh4WgnNRxY+4G+9pe9flaL6mim4nhE6MDdilc3trenk5V
 3xcNuhE2MkJky5WmerVsB9ztcJjznhU6KzPmao94OcBT8DNYELcpjzHeAe5yM54zA1BFqlzqa
 nLXKeNjqFXCQmciama+v4e+//ZKZ1HgnEHR7dg6WwOOlgyq9NV5MfkN5qF3xEIBwwAxjYEJyL
 T/cJiGpRmS/5hglDKPaZ/6gsik70qpZepePrKCU3l6U0o6xiw3B/slE8HxCy1hZSljlGcoa8s
 eo4cu7xKm+yHKsEvu6wdXIfoRYxuEEK1G/8QD8V1uiCEZDxbYR8fPt4fRn9m0PMfqlVMUlYd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280898>

On 11/04/2015 11:43 PM, Stefan Beller wrote:
> Discussion turned out a warning is not enough, but we need to die in case
> of blocking output as we can lockup the child processes.
>
> Junio wrote:
>> Imagine that we are running two things A and B at the same time.  We
>> ask poll(2) and it says both A and B have some data ready to be
>> read, and we try to read from A.  strbuf_read_once() would try to
>> read up to 8K, relying on the fact that you earlier set the IO to be
>> nonblock.
(Jumping into an old discussion, I may be off topic)

When we want to make really sure, not to get stucked, we can do like this:

ssize_t xread_nonblock(int fd, void *buf, size_t len)
{
     ssize_t nr;
     if (len > MAX_IO_SIZE)
         len = MAX_IO_SIZE;
     nr = read(fd, buf, len);
     if (nr < 0) {
        if (errno == EWOULDBLOCK)
             errno = EAGAIN;
      return nr;
}

Once poll() returns POLLIN as set on a fd, we can safely call read() once 
without getting stucked.
"Data can be read without blocking".

And this work regardless if the fd blocking or not, so from that point of view,
the set_nonblocking() is not needed at all.


The major question is, if the poll() works under Windows, (and I haven't found 
time to dig further)
