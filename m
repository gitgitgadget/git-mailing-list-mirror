Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9B72567
	for <git@vger.kernel.org>; Sat, 30 Dec 2023 03:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8gfWz34"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5f0462ee5d4so1990897b3.0
        for <git@vger.kernel.org>; Fri, 29 Dec 2023 19:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703906482; x=1704511282; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S2j6LK0tNCvw+0zS6LmVm1WW2wyGOJWf5p+mOVgOAPE=;
        b=H8gfWz34dBW3RvOF6P5Vxg8PvsvihlfkXok0Lz1hitlPAHE4Vfi1sGur/TEpP8Y5dv
         kkzGdjR7lGyv7ia9AmFuaLIeWtXL2zmEw5gh7lZPxq9rLmQl+4li2/sIhnbV5AzgaYfX
         ZaUM5pdnbBbJNIqwZPH7U5LZXSqtTzP98plX4o4nNKjwKfOb3aQngRRSENYUBHtVbSzs
         sZ6Xh5vrSWebT19JVwfkako1pXvpq+EdTynmKaERxB1YTzuwvsc1hn5g1q3Kte8aoQDx
         m+1NcQkB9nyQFJp2xu8NyIAd1AIu63OaKDgWaZpXpmfDi+XqXHbmWaGCNa+Xp7pv0YIk
         4Ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703906482; x=1704511282;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2j6LK0tNCvw+0zS6LmVm1WW2wyGOJWf5p+mOVgOAPE=;
        b=lZJjkQPd/BYgvioOwHDaoKOfE87CMTl2YyDlP28YqSqwiTqbEnNb4QAJOROTQXMF++
         7TIQZqkqlabpab7Rjufaunq3VuobMpGc+Eng7/uKVF47tDIgbXxH6DFg7oQsbSNqkZx4
         DOX1K0Uzs+RFBGsdQlUi+yIq5WhWeYscN35x75YYnzHHFkv8E4w9XIEdJMx1AD3PKZjQ
         HT9e6uQwTt2kVBYojs9tR4LSvOoSqT5Uiht6/Ejtp5FJyNAOZWvY7RdwV57q7FXSNMdW
         vOgnWit4zSXqkjY/62rKPVySLfXFIe8LesvVxocMrXnejelt7PSYI+z4BzHoWcfT+/S4
         DGJw==
X-Gm-Message-State: AOJu0Yy9F1SHv9zEISWKbF01cJ5/dKP7bIFVqwisUIvyN15JG5egAqgm
	2oAlw4R5Fo2Ifu7xf0Tt+WQlmHZoEwoWK7wvqFbUTMzMaxo=
X-Google-Smtp-Source: AGHT+IGsC6MxqZXoK8I0kBpu2gOxoaUArv9tm9x0AyCBQ1x0iy+0SnC+SOQ+fOLHLfdm5i0zum2eH1QwRBNHk+GZ6W4=
X-Received: by 2002:a25:dfd5:0:b0:dbd:c3aa:43ab with SMTP id
 w204-20020a25dfd5000000b00dbdc3aa43abmr11093930ybg.1.1703906481663; Fri, 29
 Dec 2023 19:21:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Askar Safin <safinaskar@gmail.com>
Date: Sat, 30 Dec 2023 06:20:43 +0300
Message-ID: <CAPnZJGBbA1VLAdP5mZnbF77-x-87JjU3Ku2MhrQu0SFoJL7ggw@mail.gmail.com>
Subject: [BUG] Asks for "To" even if "To" already specified in letter
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi. I found a bug. Steps to reproduce:
- Create file /tmp/m with following text:
===
Subject: subj
To: example@example.com

text
===
- Send it using command "git send-email /tmp/m"

You will see that git asks for "To". git says: "To whom should the
emails be sent (if anyone)?"
I don't like this. git should just use "To" from /tmp/m without asking.

Seen with git 2.43.0.

If I execute "git send-email --to-cmd='#' /tmp/m" or
"git send-email --to-cmd=':' /tmp/m" or
"git send-email --to-cmd='true' /tmp/m", then "To" is not asked.

Same happens when I send one single patch without cover letter. Steps
to reproduce:
- Clone some repo
- Make some (single) commit
- Execute in the repo "git send-email --annotate HEAD^"
- Editor will be spawned. Add header "To: example@example.com", then
save and exit from the editor

You will see the question "To whom should the emails be sent (if
anyone)?", too. And again you can workaround using --to-cmd tricks.

-- 
Askar Safin
