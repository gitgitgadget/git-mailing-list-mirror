From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [BUG] git-log: tracking deleted file in a repository with
 multiple "initial commit" histories
Date: Tue, 16 Feb 2016 13:24:29 -0800
Message-ID: <20160216212429.GA39536@google.com>
References: <20160216202442.GH21465@google.com>
 <20160216204557.GB27484@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 22:24:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVn6r-0006jW-41
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 22:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053AbcBPVYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 16:24:33 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36390 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755975AbcBPVYc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 16:24:32 -0500
Received: by mail-pf0-f173.google.com with SMTP id e127so111726261pfe.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 13:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wZ9DBBxFHFuCelWOspg3K3DDCeedQTleVrJ2Ei48gl0=;
        b=dPjU87C1HxBo3LdbjfEnA4QnWu74brUp4S+CvWOhLcBbL4AfQtr8s0/5xRSbuKRFtW
         YHmnCL4FX3FhANrLpf3t30npa+v0IrKPORlljtifOSXfWtLNI0zG15rcrCiOJfsVlXnT
         zk6wioG3LWte1AxGAsAiuPZP8gxl9I9RIpR8+gAm76Qu1/fV9lErKS0difRwvgujXtnw
         usZUfIMgwgBfrehM5GbGvBOzjwkAT91ZXdhZHhOqb94I0CW0Y9WdpflSWWcWT12PfawT
         ardZcLqiHi8YMideqd3XvoluQOeRxKYYCt0F5xTcRsa8o5eH3r5Rr4CE2DC6GTcOPMZN
         mdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=wZ9DBBxFHFuCelWOspg3K3DDCeedQTleVrJ2Ei48gl0=;
        b=HvrGH38VLDGCeGRYgq+XFR9GbocRZvYfMwsZAUtSiN/kPIFnST7VqwhRSAlrYJrAwN
         trBq42GwTeFernpBTR4NI0UouwEje1RMUVlqbg3vUHBH+Titi1Dc0xJQwwnG0VO4OwTf
         MRAPTPKEVb845vXtOjwC3/Qhf+TUTxHXd6YfIdd/FtEcMvumEkdpMV9YemzKNJlAD97J
         f43UIppx1oVqpPUhHBOMBRyP7+l0Ko3NJYAKzNE0kPhk3e1kAbyDoFJDnHvQ5Thl+Iwe
         z5jLbJVIBv0qZ0QNglRYjDEY4Lzv3dorTRLC7LNWv7EsQFZhbd34DAcigiWD6E/zAFgV
         5eag==
X-Gm-Message-State: AG10YOTX913cvgl/UtSdOzEPDCpK98ZTkJ2zYnTEY0I9pcQdpRSYHfXkYGs40YRfplGA5Q==
X-Received: by 10.98.14.68 with SMTP id w65mr22688819pfi.144.1455657872154;
        Tue, 16 Feb 2016 13:24:32 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:c8ef:c336:6e13:f533])
        by smtp.gmail.com with ESMTPSA id q16sm47834678pfi.80.2016.02.16.13.24.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 13:24:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160216204557.GB27484@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286434>

On Tue, Feb 16, 2016 at 03:45:57PM -0500, Jeff King wrote:
> See the section on History Simplification in git-log. But basically,
> when you specify a pathspec, git does not traverse side branches that
> had no effect on the given pathspec.

Thanks for the pointer. Is this done primarily for performance reasons,
or for UI simplicity (e.g., to avoid some kinds of double-counting)?
Seems like it generates unintuitive behaviors, but if it's helping block
other unintuitive behaviors, then maybe it can't be resolved easily.

FWIW, I quite often use git-log to look at the history of a deleted
file. Seems like a pretty big hole if the default behavior is going to
prune away the entire history of the file.

[...]

> If you want to see the full history, you can with "--full-history"
> (there are some other simplification possibilities, but I don't think
> any of them are interesting for your particular case).

--full-history gives me what I want (I'll admit, I didn't read through
all the other "History Simplification" documentation). Can I make this
the default somehow?

Brian
