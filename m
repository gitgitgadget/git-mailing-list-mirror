From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCHv2] run-command: detect finished children by closed pipe
 rather than waitpid
Date: Sat, 21 Nov 2015 07:58:38 +0100
Message-ID: <5650161E.9060305@web.de>
References: <1448053719-28340-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: jrnieder@gmail.com, johannes.schindelin@gmail.com, j6t@kdbg.org,
	tboegi@web.de
To: Stefan Beller <sbeller@google.com>, peff@peff.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 21 07:59:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a029D-0002yC-Na
	for gcvg-git-2@plane.gmane.org; Sat, 21 Nov 2015 07:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbbKUG71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2015 01:59:27 -0500
Received: from mout.web.de ([212.227.17.11]:63191 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753897AbbKUG67 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2015 01:58:59 -0500
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MgOL4-1ZfjKS3C9G-00Nkuz; Sat, 21 Nov 2015 07:58:46
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <1448053719-28340-1-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:0qlZyM8otIubpEID8rDrZRLjiBe8i/bcbzHZcQwr4DVzpvIemr+
 3ma0otI3tRqGdHYYFwCi+Rjs0F4hFdW+mLZ5eOj/m5xgAiq9qy9oWOGbSZgakdYdVz9JnYW
 0aM9oNmKk1ejbA5ROLQdrRbUfaTEYk09or45ItxNKigIOriVWx+0rHLXCEB0Wu8U7pYEFrc
 FVi7x4wdj3Eb+RVQ7G53w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+iPzHUEHLKc=:27BR7pMKWOyLmDDZ59ZMnT
 Acje11DUCiKp4BQ4uxMIMjOgRULTtuYaZp/jOxJnYwovv7rdAa3pmIadVmAJHd3osz8WRk4VD
 a7/9mASTHoVhr7u5i949lY2oi5/YGaAckL/82ZgrfvcEce6xr03qONy0hBm3Rk7r99otZwVOz
 fQwOb7ULUfM1CmsqnQiKiYBGUClHQavgo3BaOQ5sL8Gurph9g1o06RZz6uPclhr15TxJgqv99
 ybrgbMJruB9ClCVhWlNMj/qQV5gRooR6t5yTzBY/9bwOJmFptRHVn8V89ZOPlD1uoLDYNb0Lm
 M9RYMHWHAmK06KjD1+Vs/qSxMzg3LSrSVn7oajgfiliyyQcDZnDHykFfKKLN9dTi78p7OUdPG
 Q7vbwToofWnM9r+ePCLx3VB7oTGU8Kfh06vvdVD9SrJ8RHeN3ZYtLn2No9RrtxEW+6U0d7Zjw
 16aCXCUjuV2Fl1aiFQOB5c5PNhgghFpeFfT3qazqQZgz0Eujo1C/ovS586uW7leAqUWOvp/Nb
 oYM4W5UbxX2swfdPj7XbSjpV2V9dYLP/LvlVW/zQ3TC+Vr7bAFUeMhRrv94fhI3Vzuwh/aNrW
 7I6zsfzepJ47jyjyJzDDVEuPtqXD5iHmEzSBs9GxB6NhSzgOYMFU87nQBgDi/QvhDBKdQB92b
 m/lGjM5SjddTqbAYqgEr+WO7qexllYdBgYmt82vxzu2xeQFxfS4IjKWf5wHU+VVEfE2pSrzWZ
 Dw1KGHeFf02rfrbf7jWbilAMjLYZtlVUAG4BywuDvoAwL6DdQ4ozBuaFKIQ4Z4JADlsoWOPC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281544>

On 2015-11-20 22.08, Stefan Beller wrote:
The patch looks good at first glance, one minor remark below:
> 
> diff --git a/run-command.c b/run-command.c

> @@ -1071,70 +1089,31 @@ static void pp_output(struct parallel_processes *pp)
>  
>  static int pp_collect_finished(struct parallel_processes *pp)
>  {
> -	int i = 0;
> -	pid_t pid;
> -	int wait_status, code;
> +	int i, code;

code is probably "return code"?
woud "ret_value", "res" or "rc" make that more clear ?
